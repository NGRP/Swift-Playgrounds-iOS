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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        let viewController = AppsViewController()

        let ressource = AppStoreRessource()

        ressource.getTopApps(top: 100) { apps, _ in
            //
            
            viewController.list = apps
        }

        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }

}

