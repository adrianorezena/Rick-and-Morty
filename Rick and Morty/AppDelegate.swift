//
//  AppDelegate.swift
//  Rick and Morty
//
//  Created by Adriano Rezena on 22/01/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let mainTabBarControlller = MainTabBarController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mainTabBarControlller
        window?.makeKeyAndVisible()
        
        return true
    }


}

