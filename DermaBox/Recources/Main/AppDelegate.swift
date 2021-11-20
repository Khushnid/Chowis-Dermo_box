//
//  AppDelegate.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2020/07/12.
//  Copyright © 2020 Bekzod Rakhmatov. All rights reserved.
//

import UIKit
import ChowisSDK

@UIApplicationMain


class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if let _ = defaults.value(forKey: CURRENT_LANGUAGE) { } else {
            
            defaults.set("en", forKey: CURRENT_LANGUAGE)
            defaults.synchronize()
        }
        
        // temp disable FFA
//        defaults.setValue(1, forKey: FULL_FACIAL_ANALYSIS)
//        defaults.synchronize()
//        CWHandSetBroker.shared().initHandSetBroker()
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        defaults.removeObject(forKey: USER_PHONE_NUMBER)
        defaults.removeObject(forKey: USER_FIRST_NAME)
        defaults.removeObject(forKey: USER_LAST_NAME)
        defaults.removeObject(forKey: USER_BIRTHDAY)
        defaults.removeObject(forKey: USER_EMAIL_ADDRESS)
    }
}

