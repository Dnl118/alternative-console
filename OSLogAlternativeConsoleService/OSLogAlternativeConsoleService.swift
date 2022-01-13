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
            let desiredPosition = store.position(date: Date().addingTimeInterval(-secondsAgo))
            
            let predicate = NSPredicate(format: "subsystem == %@", subsystem)
            
            // Fetching log objects.
            let subsystemEntries = try store
                .getEntries(
                    with: [],
                    at: desiredPosition,
                    matching: predicate
                )
            
            // Removing other elements such as signposts,
            // converting OSLogEntry -> OSLogEntryLog.
            let filteredEntries = subsystemEntries
                .compactMap { $0 as? OSLogEntryLog }
            
            let formatter = OSLogEntryLogMessageFormatter()
            
            let messages = filteredEntries.compactMap {
                return formatter.message(entry: $0)
            }
            
            reply(messages)
            
        } catch {
            reply([error.localizedDescription])
        }
    }
}

