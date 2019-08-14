//
//  CarsMapMockController.swift
//  CarsMapTests
//
//  Created by Antonio Ruffolo on 14/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import UIKit
@testable import CarsMap

class CarsMapMockController: UIViewController, CarsMapViewProtocol
{

  var coordinate: (lat: Double, lng: Double)?
  var carsViewData: [CarLocationViewData]?
  var carsItemData: [CarListItemDataView]?
  var scrollIndex: Int?

  var erroMessage: String?

  override func viewDidLoad()
  {
    super.viewDidLoad()
  }

  func zoomToLocation(coordinate: (lat: Double, lng: Double))
  {
    self.coordinate = coordinate
  }

  func addPoisToMap(carsViewData: [CarLocationViewData])
  {
    self.carsViewData = carsViewData
  }

  func goTolist(carsItemData: [CarListItemDataView])
  {
    self.carsItemData = carsItemData
  }

  func showErrorForDataFailure(title: String, message: String, buttonLabel: String)
  {
    self.erroMessage = message
  }

  func fillCollectionView(carsItemData: [CarListItemDataView])
  {
    // nothing to do here
  }

  func scrollCollectionTo(index: Int)
  {
    self.scrollIndex = index
  }

  func showError(title: String, message: String, buttonLabel: String)
  {
    // nothing to do here
  }
}
