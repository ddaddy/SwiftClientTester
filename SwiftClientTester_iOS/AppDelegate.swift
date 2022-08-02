//
//  AppDelegate.swift
//  SwiftClientTester_iOS
//
//  Created by Darren Jones on 02/08/2022.
//

import UIKit
import TelemetryClient

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let YOUR_APP_ID = "44e0f59a-60a2-4d4a-bf27-1f96ccb4aaa3"
        let configuration = TelemetryManagerConfiguration(appID: YOUR_APP_ID)
        configuration.showDebugLogs = true
        configuration.testMode = !Bundle.main.isProduction
        
        TelemetryManager.initialize(with: configuration)
        
        TelemetryManager.send("applicationDidFinishLaunching")
        
        return true
    }
}

fileprivate extension Bundle {
    var isProduction: Bool {
        #if DEBUG
            return false
        #else
            guard let path = self.appStoreReceiptURL?.path else {
                return true
            }
            return !path.contains("sandboxReceipt")
        #endif
    }
}
