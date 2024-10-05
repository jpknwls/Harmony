//
//  Logger.swift
//  SQLight
//
//  Created by Aaron Pearce on 8/06/23.
//
import os.log

extension Logger {

    static let loggingSubsystem: String = "com.overlair.SQLight"

    static let database = Logger(subsystem: Self.loggingSubsystem, category: "Database")
}
