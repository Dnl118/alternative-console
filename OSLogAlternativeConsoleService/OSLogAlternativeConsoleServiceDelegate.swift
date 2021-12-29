//
//  OSLogAlternativeConsoleServiceDelegate.swift
//  OSLogAlternativeConsoleService
//
//  Created by Danilo de Sousa on 28/12/21.
//

import Foundation

class OSLogAlternativeConsoleServiceDelegate: NSObject, NSXPCListenerDelegate {
    func listener(_ listener: NSXPCListener, shouldAcceptNewConnection newConnection: NSXPCConnection) -> Bool {
        
        newConnection.exportedInterface = NSXPCInterface(with: OSLogAlternativeConsoleServiceProtocol.self)
        newConnection.exportedObject = OSLogAlternativeConsoleService()
        newConnection.resume()
        
        return true
    }
}
