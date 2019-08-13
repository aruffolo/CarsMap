//
//  AppCoordinator.swift
//  CarsMap
//
//  Created by Antonio Ruffolo on 13/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator
{
  private weak var mapController: CarsMapViewController?
  private weak var navController: UINavigationController?

  init(mapController: CarsMapViewController, navController: UINavigationController)
  {
    self.mapController = mapController
    self.navController = navController

    configureController()
  }

  private func configureController()
  {
    let locatioManager = CarsLocationManager()
    let mapViewModel = CarsMapViewModel(view: mapController, locationManager: locatioManager)
    locatioManager.delegate = mapViewModel
    self.mapController?.viewModel = mapViewModel
  }
}
