//
//  AppDelegate.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/14.
//

import UIKit
import GoogleMobileAds
import Mixpanel

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if let mixPanelToken = Bundle.main.mixpanelToken {
            Mixpanel.initialize(token: mixPanelToken, trackAutomaticEvents: true)
        }
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        return true
    }
 
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        
        // 세로모드 고정
        return UIInterfaceOrientationMask.portrait
    }
}

