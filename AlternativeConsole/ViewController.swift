//
//  ViewController.swift
//  AlternativeConsole
//
//  Created by Danilo de Sousa on 28/12/21.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var subsystemTextField: NSTextField!
    @IBOutlet weak var secondsTextField: NSTextField!
    
    @IBOutlet var outputTextView: NSTextView!
    
    private let defaultSeconds: TimeInterval = 1800
    private let defaultSubsystem = "com.apple.loginwindow.logging"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subsystemTextField.stringValue = defaultSubsystem
        secondsTextField.stringValue = "\(defaultSeconds)"
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        prepareForLoginWindow()
    }
    
    @IBAction func okClick(_ sender: Any) {
        let subsytem = subsystemTextField.stringValue
        
        let seconds: TimeInterval = {
            if let seconds = TimeInterval(secondsTextField.stringValue) {
                return seconds
            } else {
                return defaultSeconds
            }
        }()
        
        secondsTextField.stringValue = "\(seconds)"
        
        OSLogServiceCaller.entries(subsystem: subsytem, from: seconds) { messages in
            DispatchQueue.main.async {
                self.outputTextView.string = messages.joined(separator: "\n")
            }
        }
    }
    
    private func prepareForLoginWindow() {
        if NSUserName() == "root" {
            view.window?.canBecomeVisibleWithoutLogin = true
            view.window?.level = .screenSaver
            view.window?.orderFrontRegardless()
        }
    }
}

