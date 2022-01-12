//
//  OSLogAlternativeConsoleServiceProtocol.swift
//  OSLogAlternativeConsoleService
//
//  Created by Danilo de Sousa on 28/12/21.
//

import Foundation

@objc public protocol OSLogAlternativeConsoleServiceProtocol {
    func entries(
        subsystem: String,
        from secondsAgo: TimeInterval,
        withReply reply: @escaping ([String]) -> Void
    )
}
