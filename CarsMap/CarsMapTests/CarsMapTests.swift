//
//  CarsMapTests.swift
//  CarsMapTests
//
//  Created by Antonio Ruffolo on 12/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import XCTest
@testable import CarsMap

class CarsMapTests: XCTestCase
{
  override func setUp()
  {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown()
  {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testLoadData()
  {
    let viewController = CarsMapMockController()
    let locationManager = CarsLocationManager()
    let fetcher = CarsListFetcherMock()
    let viewModel = CarsMapViewModel(view: viewController, locationManager: locationManager, carsFetcher: fetcher)

    viewModel.loadData()
    XCTAssert(viewController.carsItemData == nil)
    XCTAssert(viewController.carsViewData?.count == 3)
    XCTAssert(viewController.coordinate != nil)
  }

  func testGoToList()
  {
    let viewController = CarsMapMockController()
    let locationManager = CarsLocationManager()
    let fetcher = CarsListFetcherMock()
    let viewModel = CarsMapViewModel(view: viewController, locationManager: locationManager, carsFetcher: fetcher)

    viewModel.goToListTapped()
    XCTAssert(viewController.carsItemData?.count == 3)
  }

  func testLoadDataNoService()
  {
    let viewController = CarsMapMockController()
    let locationManager = CarsLocationManager()
    let fetcher = CarsListFetcherMock()
    fetcher.loadServiceNotAvailable = true
    let viewModel = CarsMapViewModel(view: viewController, locationManager: locationManager, carsFetcher: fetcher)

    viewModel.loadData()
    XCTAssert(viewController.erroMessage == AppStrings.serviceUnavailable.value)
  }

  func testGoToListEmptyList()
  {
    let viewController = CarsMapMockController()
    let locationManager = CarsLocationManager()
    let fetcher = CarsListFetcherMock()
    fetcher.loadServiceError = true
    let viewModel = CarsMapViewModel(view: viewController, locationManager: locationManager, carsFetcher: fetcher)

    viewModel.goToListTapped()
    XCTAssert(viewController.erroMessage == AppStrings.dataNotFound.value)
  }
  
  func testAnnotationTapped()
  {
    let viewController = CarsMapMockController()
    let locationManager = CarsLocationManager()
    let fetcher = CarsListFetcherMock()
    let viewModel = CarsMapViewModel(view: viewController, locationManager: locationManager, carsFetcher: fetcher)

    viewModel.loadData()
    viewModel.annotationTapped(carId: "a")
    XCTAssert(viewController.scrollIndex == 0)
  }

  func testZoomToCarLocation()
  {
    let viewController = CarsMapMockController()
    let locationManager = CarsLocationManager()
    let fetcher = CarsListFetcherMock()
    let viewModel = CarsMapViewModel(view: viewController, locationManager: locationManager, carsFetcher: fetcher)

    viewModel.loadData()
    viewModel.goToListTapped()

    viewModel.zoomToCarLocationView(indexOfCardListItem: 0)

    XCTAssert(viewController.coordinate != nil)
  }
}
