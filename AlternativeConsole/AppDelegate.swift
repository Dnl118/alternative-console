//
//  AppDelegate.swift
//  AlternativeConsole
//
//  Created by Danilo de Sousa on 28/12/21.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        OSLogServiceCaller.entries { messages in
            messages.forEach {
                print($0)
            }
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
    
}

