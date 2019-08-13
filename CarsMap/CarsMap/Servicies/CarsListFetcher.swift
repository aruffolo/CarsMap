//
//  CarsListFetcher.swift
//  CarsMap
//
//  Created by Antonio Ruffolo on 13/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation

enum CarsFetcherError: Error
{
  case serviceUnavailable
  case emptyList
}

protocol CarsListFetcherProtocol
{
  func getCarsList(completion: @escaping (_ result: Result<[CarLocationViewData], CarsFetcherError>) -> Void)
}

struct CarsListFetcher: CarsListFetcherProtocol
{
  let restClient: RestClientProtocol

  init(restClient: RestClientProtocol)
  {
    self.restClient = restClient
  }

  func getCarsList(completion: @escaping (_ result: Result<[CarLocationViewData], CarsFetcherError>) -> Void)
  {
    restClient.getCarsList(completion: { result in
      switch result
      {
      case .success(let response):
        let result = self.handleResponseReceived(response: response)
        completion(result)
      case .failure:
        completion(.failure(.emptyList))
      }
    })
  }

  private func handleResponseReceived(response: CarsList) -> Result<[CarLocationViewData], CarsFetcherError>
  {
    let filtered = response.filter(self.validateResponseItem)
    if filtered.isEmpty
    {
      return .failure(.emptyList)
    }
    return .success(self.createViewData(carList: filtered))
  }

  private func validateResponseItem(carItem: CarsListElement) -> Bool
  {
    return carItem.latitude != nil && carItem.longitude != nil && carItem.modelName != nil
  }

  private func createViewData(carList: CarsList) -> [CarLocationViewData]
  {
    return carList.map {
      guard let lat = $0.latitude, let lng = $0.longitude, let name = $0.modelName else {
        fatalError("Items here should already be filtered")
      }
      return CarLocationViewData(lat: lat, lng: lng, name: name)
    }
  }
}
