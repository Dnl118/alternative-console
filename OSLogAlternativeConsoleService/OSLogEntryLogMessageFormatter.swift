//
//  OSLogEntryLogMessageFormatter.swift
//  OSLogAlternativeConsoleService
//
//  Created by Danilo de Sousa on 12/01/22.
//

import Foundation
import OSLog

struct OSLogEntryLogMessageFormatter {
    
    private let dateFormatter: DateFormatter
    
    init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    }
    
    func message(entry: OSLogEntryLog) -> String {
        let values: [String] = [
            dateFormatter.string(from: entry.date),
            "[\(readableLevel(entryLevel: entry.level))]",
            entry.process,
            entry.composedMessage
        ]
        
        return values.joined(separator: "  ")
    }
    
    private func readableLevel(entryLevel: OSLogEntryLog.Level) -> String {
        switch entryLevel {
        case .undefined:
            return "undefined"
        case .debug:
            return "debug"
        case .info:
            return "info"
        case .notice:
            return "notice"
        case .error:
            return "error"
        case .fault:
            return "fault"
        @unknown default:
            return "unknoen"
        }
    }
}
