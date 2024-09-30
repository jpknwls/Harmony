//
//  Harmonic+CRUD.swift
//  Harmony
//
//  Created by Aaron Pearce on 11/06/23.
//

import Foundation
import GRDB
import CloudKit
import os.log

public extension Harmonic {

    func read<T>(_ block: (Database) throws -> T) throws -> T {
        try reader.read(block)
    }

    func read<T>(_ block: @Sendable @escaping (Database) throws -> T) async throws -> T {
        try await reader.read { db in
            try block(db)
        }
    }

    func create<T: HRecord>(record: T) async throws {
        try await database.write { db in
            try record.insert(db)
        }

        queueSaves(for: [record])
    }
    
    func create<T: HRecord>(records: [T]) async throws {
        try await database.write { db in
            try records.forEach {
                try $0.insert(db)
            }
        }
        queueSaves(for: records)
    }

    func save<T: HRecord>(record: T) async throws {
        try await database.write { db in
            try record.save(db)
        }

        queueSaves(for: [record])
    }

    func save<T: HRecord>(records: [T]) async throws {
        _ = try await database.write { db in
            try records.forEach {
                try $0.save(db)
            }
        }

        queueSaves(for: records)
    }

    func delete<T: HRecord>(record: T) async throws {
        _ = try await database.write { db in
            try record.delete(db)
        }

        queueDeletions(for: [record])
    }

    func delete<T: HRecord>(records: [T]) async throws {
        _ = try await database.write { db in
            try records.forEach {
                try $0.delete(db)
            }
        }

        queueDeletions(for: records)
    }

    private func queueSaves(for records: [any HRecord]) {
        Logger.database.info("Queuing saves")
        let pendingSaves: [CKSyncEngine.PendingRecordZoneChange] = records.map { 
            .saveRecord($0.recordID)
        }

        self.syncEngine.state.add(pendingRecordZoneChanges: pendingSaves)
    }

    private func queueDeletions(for records: [any HRecord]) {
        Logger.database.info("Queuing deletions")
        let pendingDeletions: [CKSyncEngine.PendingRecordZoneChange] = records.map {
            .deleteRecord($0.recordID)
        }

        self.syncEngine.state.add(pendingRecordZoneChanges: pendingDeletions)
    }

    func sendChanges() async throws {
        try await self.syncEngine.sendChanges()
    }

    func fetchChanges() async throws {
        try await self.syncEngine.fetchChanges()
    }
}

public extension Harmonic {

    func fetchURL(id: String, key: String, completion: @escaping (URL?, Error?) -> ()) {
        let recordID = CKRecord.ID(recordName: id)
        let fetchOperation = CKFetchRecordsOperation(recordIDs: [recordID])
           fetchOperation.desiredKeys = [key]
        fetchOperation.perRecordResultBlock = { (record: CKRecord.ID, result: Result<CKRecord, Error>) -> Void in
               switch result {
               case .failure(let error):
                   completion(nil,  error)
                   break
               case .success(let record):
                   if let asset = record[key] as? CKAsset,
                        let url = asset.fileURL {
                       completion(url,  nil)
                   } else {
//                       completion(nil,  error)
                   }
                   break
               }
              
           }
        
        self.syncEngine.database.add(fetchOperation)
        
    }
}
