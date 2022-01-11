//
//  OSLogServiceCaller.swift
//  AlternativeConsole
//
//  Created by Danilo de Sousa on 28/12/21.
//

import Foundation

class OSLogServiceCaller {
    static let serviceName = "com.dnl.labs.OSLogAlternativeConsoleService"
    
    class func entries(
        subsystem: String,
        from seconds: TimeInterval,
        withReply reply: @escaping ([String]) -> Void
    ) {
        let connection = NSXPCConnection(serviceName: serviceName)
        connection.remoteObjectInterface = NSXPCInterface(with: OSLogAlternativeConsoleServiceProtocol.self)
        connection.resume()
        
        let service = connection.remoteObjectProxyWithErrorHandler { error in
            print("Unable to connect to \(serviceName) due to \(error.localizedDescription)")
        } as? OSLogAlternativeConsoleServiceProtocol
        
        service?.entries(
            subsystem: subsystem,
            from: seconds,
            withReply: reply
        )
    }
}
