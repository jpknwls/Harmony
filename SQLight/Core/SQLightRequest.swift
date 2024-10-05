//
//  File.swift
//  
//
//  Created by John Knowles on 10/2/24.
//

import Foundation
import GRDB

public struct SQLightRequest {
    public init(sql: String, 
                arguments: StatementArguments = [],
                adapter: RowAdapter? = nil) {
        self.sql = sql
        self.arguments = arguments
        self.adapter = adapter
    }
    public let sql: String
    public let arguments: StatementArguments
    public let adapter: RowAdapter?
}
