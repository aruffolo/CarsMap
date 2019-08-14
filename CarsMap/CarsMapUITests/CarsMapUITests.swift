//
//  CarsMapUITests.swift
//  CarsMapUITests
//
//  Created by Antonio Ruffolo on 12/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import XCTest

class CarsMapUITests: XCTestCase
{
  var app: XCUIApplication!

  override func setUp()
  {
    continueAfterFailure = false

    app = XCUIApplication()
    app.launch()
  }

  // Test added only for example
  func testExample()
  {
    app.buttons["SHOW CARS LIST"].tap()
    app.navigationBars["CarsMap.CarsListView"].buttons["Back"].tap()

    XCTAssert(app.buttons["SHOW CARS LIST"].exists)
  }
}
