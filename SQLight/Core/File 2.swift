//
//  File 2.swift
//  
//
//  Created by John Knowles on 10/2/24.
//

import GRDB
import Foundation

public extension ValueObservation {
    
//    static func observeMany<T:FetchableRecord>(
//                                    _ record: T.Type,
//                                    reader:  AnyDatabaseReader,
//                                    request: SQLightRequest,
//                                    scheduler: ValueObservationScheduler,
//                                    onError: @escaping (Error) -> Void,
//                                    onChange: @escaping ([T]) -> Void) -> AnyDatabaseCancellable {
//        ValueObservation
//            .tracking { db in
//               try record.fetchAll(db,
//                           sql: request.sql,
//                           arguments: request.arguments,
//                           adapter: request.adapter)
//            }
//            .start(in: reader,
//                   scheduling: scheduler,
//                   onError: onError,
//                   onChange: onChange)
//    }
//    
//    
//    static  func observeOne<T:FetchableRecord>(
//                                    _ record: T.Type,
//                                    request: SQLightRequest,
//                                    scheduler: ValueObservationScheduler,
//                                    onError: @escaping (Error) -> Void,
//                                    onChange: @escaping (T?) -> Void) -> AnyDatabaseCancellable {
//        ValueObservation
//            .tracking { db in
//               try record.fetchOne(db,
//                           sql: request.sql,
//                           arguments: request.arguments,
//                           adapter: request.adapter)
//            }
//            .start(in: self.reader,
//                   scheduling: scheduler,
//                   onError: onError,
//                   onChange: onChange)
//    }

}
