//
//  CarsMapServiciesTests.swift
//  CarsMapTests
//
//  Created by Antonio Ruffolo on 14/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import XCTest
@testable import CarsMap

class CarsMapServiciesTests: XCTestCase
{
  override func setUp()
  {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown()
  {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testCarsListDataSuccess()
  {
    let restClientMock = RestClientMock()
    let fetcher = CarsListFetcher(restClient: restClientMock)

    let completedExpectation = expectation(description: "Completed")

    fetcher.getCarsListData(completion: { result in
      switch result
      {
      case .success:
        completedExpectation.fulfill()
        XCTAssert(true)
      case .failure:
        completedExpectation.fulfill()
        XCTFail("response should have arrived")
      }
    })

    waitForExpectation()
  }

  func testCarsListDataFailure()
  {
    let restClientMock = RestClientMock()
    restClientMock.failure = true
    let fetcher = CarsListFetcher(restClient: restClientMock)

    let completedExpectation = expectation(description: "Completed")

    fetcher.getCarsListData(completion: { result in
      switch result
      {
      case .success:
        completedExpectation.fulfill()
        XCTFail("response should have not arrived")
      case .failure:
        completedExpectation.fulfill()
        XCTAssert(true)
      }
    })

    waitForExpectation()
  }

  func testCarsLocationDataSuccess()
  {
    let restClientMock = RestClientMock()
    let fetcher = CarsListFetcher(restClient: restClientMock)

    let completedExpectation = expectation(description: "Completed")

    fetcher.getCarsLocationData(completion: { result in
      switch result
      {
      case .success:
        completedExpectation.fulfill()
        XCTAssert(true)
      case .failure:
        completedExpectation.fulfill()
        XCTFail("response should have arrived")
      }
    })

    waitForExpectation()
  }

  func testCarsLocationDataFailure()
  {
    let restClientMock = RestClientMock()
    let fetcher = CarsListFetcher(restClient: restClientMock)
    restClientMock.failure = true
    let completedExpectation = expectation(description: "Completed")

    fetcher.getCarsLocationData(completion: { result in
      switch result
      {
      case .success:
        completedExpectation.fulfill()
        XCTFail("response should have not arrived")
      case .failure:
        completedExpectation.fulfill()
        XCTAssert(true)
      }
    })

    waitForExpectation()
  }

  func testEmptyListForLocation()
  {
    let restClientMock = RestClientMock()
    let fetcher = CarsListFetcher(restClient: restClientMock)
    restClientMock.returnEmpty = true
    let completedExpectation = expectation(description: "Completed")

    fetcher.getCarsLocationData(completion: { result in
      switch result
      {
      case .success:
        completedExpectation.fulfill()
        XCTFail("response should have not arrived")
      case .failure(let error):
        completedExpectation.fulfill()
        XCTAssert(error == .emptyList)
      }
    })

    waitForExpectation()
  }

  func testEmptyListForListItemData()
  {
    let restClientMock = RestClientMock()
    let fetcher = CarsListFetcher(restClient: restClientMock)
    restClientMock.returnEmpty = true
    let completedExpectation = expectation(description: "Completed")

    fetcher.getCarsListData(completion: { result in
      switch result
      {
      case .success:
        completedExpectation.fulfill()
        XCTFail("response should have not arrived")
      case .failure(let error):
        completedExpectation.fulfill()
        XCTAssert(error == .emptyList)
      }
    })

    waitForExpectation()
  }

  func testRestClient()
  {
    let restClient = RestClient()
    let completedExpectation = expectation(description: "Completed")

    restClient.getCarsList(completion: { result in
      switch result
      {
      case .success(let response):
        completedExpectation.fulfill()
        XCTAssert(!response.isEmpty)
      case .failure:
        completedExpectation.fulfill()
        XCTFail("response should have arrived")
      }
    })

    waitForExpectation()
  }

  private func waitForExpectation()
  {
    waitForExpectations(timeout: 5, handler: { error in
      if error != nil
      {
        XCTFail("waitForExpectationsWithTimeout errored: \(String(describing: error))")
      }
    })
  }
}
