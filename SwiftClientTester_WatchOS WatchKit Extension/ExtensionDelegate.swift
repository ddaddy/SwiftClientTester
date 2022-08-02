//
//  ExtensionDelegate.swift
//  SwiftClientTester_WatchOS WatchKit Extension
//
//  Created by Darren Jones on 02/08/2022.
//

import WatchKit
import TelemetryClient

class ExtensionDelegate: NSObject, WKExtensionDelegate {

    func applicationDidFinishLaunching() {
        
        let YOUR_APP_ID = "44e0f59a-60a2-4d4a-bf27-1f96ccb4aaa3"
        let configuration = TelemetryManagerConfiguration(appID: YOUR_APP_ID)
        configuration.showDebugLogs = true
        configuration.testMode = !Bundle.main.isProduction
        
        TelemetryManager.initialize(with: configuration)
        
        TelemetryManager.send("applicationDidFinishLaunching")
    }

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }
    
    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
        for task in backgroundTasks {
            switch task {
            case let backgroundTask as WKApplicationRefreshBackgroundTask:
                // Be sure to complete the background task once you’re done.
                backgroundTask.setTaskCompletedWithSnapshot(false)
            case let snapshotTask as WKSnapshotRefreshBackgroundTask:
                // Snapshot tasks have a unique completion call, make sure to set your expiration date
                snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: Date.distantFuture, userInfo: nil)
            case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
                // Be sure to complete the connectivity task once you’re done.
                connectivityTask.setTaskCompletedWithSnapshot(false)
            case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
                // Be sure to complete the URL session task once you’re done.
                urlSessionTask.setTaskCompletedWithSnapshot(false)
            default:
                if #available(watchOS 5.0, *)
                {
                    if case let relevantShortcutTask as WKRelevantShortcutRefreshBackgroundTask = task
                    {
                        // Be sure to complete the relevant-shortcut task once you're done.
                        relevantShortcutTask.setTaskCompletedWithSnapshot(false)
                    }
                    else if case let intentDidRunTask as WKIntentDidRunRefreshBackgroundTask = task
                    {
                        // Be sure to complete the intent-did-run task once you're done.
                        intentDidRunTask.setTaskCompletedWithSnapshot(false)
                    }
                }
                // make sure to complete unhandled task types
                task.setTaskCompletedWithSnapshot(false)
            }
        }
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
