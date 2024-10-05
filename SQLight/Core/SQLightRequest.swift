//
//  File.swift
//  
//
//  Created by John Knowles on 10/2/24.
//

import Foundation
import GRDB

public struct SQLightRequest {
    public let sql: String
    public var arguments: StatementArguments = []
    public var adapter: RowAdapter? = nil
}
