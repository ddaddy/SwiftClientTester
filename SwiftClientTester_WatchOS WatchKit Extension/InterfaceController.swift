//
//  InterfaceController.swift
//  SwiftClientTester_WatchOS WatchKit Extension
//
//  Created by Darren Jones on 02/08/2022.
//

import WatchKit
import Foundation
import TelemetryClient

class InterfaceController: WKInterfaceController {
    
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }
    
    @IBAction func buttonPressed() {
        
        for _ in 0 ..< 100 {
            TelemetryManager.send("boop")
        }
    }
}
