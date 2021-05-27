//
//  AppDelegate.swift
//  rmcase
//
//  Created by ANIL Turan on 27.05.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)

        let viewController = CharactersViewController()

        let NC = UINavigationController(rootViewController: viewController)
        self.window?.rootViewController = NC
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

