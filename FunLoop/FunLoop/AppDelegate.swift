//
//  AppDelegate.swift
//  FunLoop
//
//  Created by Mikey Ward on 7/8/21.
//

import UIKit
import CoreFoundation
import OSLog

let log = Logger(subsystem: "\(ProcessInfo().processName)[\(Bundle.main.bundleIdentifier ?? "unknown bundle")]", category: "")

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var loopCount = 0

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let runloop = CFRunLoopGetMain()
        let observer = CFRunLoopObserverCreateWithHandler(nil, CFRunLoopActivity.beforeWaiting.rawValue, true, 0) {
            obs, act in
            self.loopCount += 1
            print("\(Date()) [LOOP] \(self.loopCount) finished")
        }
        CFRunLoopAddObserver(runloop, observer, .commonModes)

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

