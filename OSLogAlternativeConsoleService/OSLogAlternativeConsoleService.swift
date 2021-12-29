//
//  OSLogAlternativeConsoleService.swift
//  OSLogAlternativeConsoleService
//
//  Created by Danilo de Sousa on 28/12/21.
//

import Foundation
import OSLog

class OSLogAlternativeConsoleService: NSObject, OSLogAlternativeConsoleServiceProtocol {
    
    func entries(withReply reply: @escaping ([String]) -> Void) {
        
        do {
            let store = try OSLogStore.local()
            
            let postion = store.position(timeIntervalSinceEnd: -5)
            
            let entries = try store.getEntries(with: [], at: postion, matching: nil)
            
            let messages = entries.compactMap {
                return "\($0.date) \($0.composedMessage)"
            }
            
            reply(messages)
            
        } catch {
            print(error)
            reply([])
        }
    }
}

