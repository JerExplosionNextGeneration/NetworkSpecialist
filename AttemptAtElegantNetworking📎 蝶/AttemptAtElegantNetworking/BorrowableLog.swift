//
//  BorrowableLog.swift
//  AttemptAtElegantNetworking
//
//  Created by Jerry Ren on 11/10/20.
//

import Foundation

enum BorrowableLog {
    static let level: Level = .verbose

    enum Level: Int {
        case none = 0
        case verbose = 3
        case info = 2
        case error = 1

        func shouldLog(_ level: Level) -> Bool {
            return level.rawValue <= self.rawValue
        }
    }

    static func assertFailure(_ message: @autoclosure () -> String, file: StaticString = #file, line: UInt = #line) {
        #if DEBUG
        assertionFailure(message(), file: file, line: line)
        #else
        #endif
    }

    static func assert(_ condition: @autoclosure () -> Bool, _ message: @autoclosure () -> String, file: StaticString = #file, line: UInt = #line) {
        if !condition() {
            assertFailure(message(), file: file, line: line)
        }
    }

    static func verbose(_ message: @autoclosure () -> String, file: StaticString = #file, line: UInt = #line) {
        if level.shouldLog(.verbose) {
            print(message())
        }
    }

    static func info(_ message: @autoclosure () -> String, file: StaticString = #file, line: UInt = #line) {
        if level.shouldLog(.info) {
            print(message())
        }
    }

    static func error(_ message: @autoclosure () -> String, file: StaticString = #file, line: UInt = #line) {

        if level.shouldLog(.error) {
            print(message())
        }
    }
}



