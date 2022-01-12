//
//  OSLogAlternativeConsoleService.swift
//  OSLogAlternativeConsoleService
//
//  Created by Danilo de Sousa on 28/12/21.
//

import Foundation
import OSLog

class OSLogAlternativeConsoleService: NSObject, OSLogAlternativeConsoleServiceProtocol {
    
    func entries(
        subsystem: String,
        from secondsAgo: TimeInterval,
        withReply reply: @escaping ([String]) -> Void
    ) {
        
        do {
            let store = try OSLogStore.local()
            
            // Setting the desired position.
            let oneHourAgo = store.position(date: Date().addingTimeInterval(-secondsAgo))
            
            let predicate = NSPredicate(format: "subsystem == %@", subsystem)
            
            // Fetching log objects.
            let subsystemEntries = try store
                .getEntries(
                    with: [],
                    at: oneHourAgo,
                    matching: predicate
                )
            
            // Removing other elements such as signposts,
            // converting OSLogEntry -> OSLogEntryLog.
            let filteredEntries = subsystemEntries
                .compactMap { $0 as? OSLogEntryLog }
            
            let messages = filteredEntries.compactMap {
                return makeMessage(entry: $0)
            }
            
            reply(messages)
            
        } catch {
            reply([error.localizedDescription])
        }
    }
    
    private func makeMessage(entry: OSLogEntryLog) -> String {
        return "\(entry.date) \(makeReadableLevel(entryLevel: entry.level)) \(entry.process) \(entry.composedMessage)"
    }
    
    private func makeReadableLevel(entryLevel: OSLogEntryLog.Level) -> String {
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

