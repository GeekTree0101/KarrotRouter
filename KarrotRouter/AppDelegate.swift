//
//  AppDelegate.swift
//  KarrotRouter
//
//  Created by Geektree0101 on 2020/07/01.
//  Copyright © 2020 Geektree0101. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    self.window = UIWindow(frame: UIScreen.main.bounds)
    self.window?.rootViewController = UINavigationController(
      rootViewController: FeedViewController()
    )
    self.window?.makeKeyAndVisible()
    return true
  }
}

