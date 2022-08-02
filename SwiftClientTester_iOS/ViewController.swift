//
//  ViewController.swift
//  SwiftClientTester_iOS
//
//  Created by Darren Jones on 02/08/2022.
//

import UIKit
import TelemetryClient

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        
        for _ in 0 ..< 100 {
            TelemetryManager.send("boop")
        }
    }
}

