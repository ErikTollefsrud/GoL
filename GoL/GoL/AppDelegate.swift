//
//  AppDelegate.swift
//  FinalProject
//
//  Created by Van Simmons on 7/24/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(named: "accent") ?? UIColor.black]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(named: "accent") ?? UIColor.black]
        UINavigationBar.appearance().tintColor = UIColor(named: "accent") ?? UIColor.black
        UISwitch.appearance().onTintColor = UIColor(named: "accent")
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

