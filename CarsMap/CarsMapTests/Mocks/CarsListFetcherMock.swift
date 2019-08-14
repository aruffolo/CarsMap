//
//  CarsListFetcherMock.swift
//  CarsMapTests
//
//  Created by Antonio Ruffolo on 14/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation
@testable import CarsMap

class CarsListFetcherMock: CarsListFetcherProtocol
{
  var loadServiceNotAvailable: Bool = false
  var loadServiceError: Bool = false

  func getCarsLocationData(completion: @escaping (Result<[CarLocationViewData], CarsFetcherError>) -> Void)
  {
    if loadServiceNotAvailable
    {
      completion(.failure(.serviceUnavailable))
    }
    else if loadServiceError
    {
      completion(.failure(.emptyList))
    }
    else
    {
      completion(.success(Constants.carLocationList))
    }
  }

  func getCarsListData(completion: @escaping (Result<[CarListItemDataView], CarsFetcherError>) -> Void)
  {
    if loadServiceNotAvailable
    {
      completion(.failure(.serviceUnavailable))
    }
    else if loadServiceError
    {
      completion(.failure(.emptyList))
    }
    else
    {
      completion(.success(Constants.carListViewData))
    }
  }
}
