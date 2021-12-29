//
//  main.swift
//  OSLogAlternativeConsoleService
//
//  Created by Danilo de Sousa on 28/12/21.
//

import Foundation

let delegate = OSLogAlternativeConsoleServiceDelegate()
let listener = NSXPCListener.service()

listener.delegate = delegate
listener.resume()
