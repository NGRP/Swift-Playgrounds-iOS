//
//  AppDelegate.swift
//  AppStoreViewer
//
//  Created by Gil Nakache on 17/10/2018.
//  Copyright © 2018 Viseo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        let viewController = RootAppsCoordinator()

        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }
}
