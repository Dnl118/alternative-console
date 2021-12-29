//
//  OSLogAlternativeConsoleServiceProtocol.swift
//  OSLogAlternativeConsoleService
//
//  Created by Danilo de Sousa on 28/12/21.
//

import Foundation

@objc public protocol OSLogAlternativeConsoleServiceProtocol {
    func entries(withReply reply: @escaping ([String]) -> Void)
}
