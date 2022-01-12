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
    
    private let defaultSeconds: TimeInterval = 60
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        secondsTextField.stringValue = "\(defaultSeconds)"
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
}

