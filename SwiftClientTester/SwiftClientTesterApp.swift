//
//  SwiftClientTesterApp.swift
//  SwiftClientTester
//
//  Created by Daniel Jilg on 22.06.21.
//

import SwiftUI
import TelemetryClient

@main
struct SwiftClientTesterApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    init() {
        let YOUR_APP_ID = "44e0f59a-60a2-4d4a-bf27-1f96ccb4aaa3"
        let configuration = TelemetryManagerConfiguration(appID: YOUR_APP_ID)
        configuration.showDebugLogs = true
        configuration.testMode = !Bundle.main.isProduction
        
        TelemetryManager.initialize(with: configuration)
        
        TelemetryManager.send("applicationDidFinishLaunching")
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
