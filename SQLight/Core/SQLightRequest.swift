//
//  File.swift
//  
//
//  Created by John Knowles on 10/2/24.
//

import Foundation
import GRDB

public struct SQLightRequest {
    let sql: String
    var arguments: StatementArguments = []
    var adapter: RowAdapter? = nil
}
