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
    let restClient = RestClient()
    let carsFetcher = CarsListFetcher(restClient: restClient)
    let locatioManager = CarsLocationManager()
    let mapViewModel = CarsMapViewModel(view: mapController,
                                        locationManager: locatioManager,
                                        carsFetcher: carsFetcher)
    locatioManager.delegate = mapViewModel
    self.mapController?.viewModel = mapViewModel

    self.mapController?.goToListClosure = { [weak self] dataList in
      self?.goToCarListViewController(carListItems: dataList)
    }
  }

  private func goToCarListViewController(carListItems: [CarListItemDataView])
  {
    let viewController = CarsListViewController.initViewController(itemDataView: carListItems)
    navController?.pushViewController(viewController, animated: true)
  }
}
