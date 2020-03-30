//
//  AppDelegate.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/08/20.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = AppsTabBarController()
        window?.makeKeyAndVisible()

        return true
    }
}
