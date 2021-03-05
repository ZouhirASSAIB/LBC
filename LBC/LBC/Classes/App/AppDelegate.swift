//
//  AppDelegate.swift
//  LBC
//
//  Created by Zouhair ASSAIB on 05/03/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        window?.backgroundColor = .white
        window?.rootViewController = AdvertisementsRouter.createModule()
        window?.makeKeyAndVisible()
        
        return true
    }
}

