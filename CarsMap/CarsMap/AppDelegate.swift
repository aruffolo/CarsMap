//
//  AppDelegate.swift
//  CarsMap
//
//  Created by Antonio Ruffolo on 12/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var appCoordinator: AppCoordinator!

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    guard let navController = self.window?.rootViewController as? UINavigationController,
    let mapController = navController.viewControllers.first as? CarsMapViewController else {
      fatalError("Navigation controller and CarsMapViewController must be root controller and firnst controller")
    }

    appCoordinator = AppCoordinator(mapController: mapController, navController: navController)

    return true
  }
}
