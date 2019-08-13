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
  func getCarsLocationData(completion: @escaping (_ result: Result<[CarLocationViewData], CarsFetcherError>) -> Void)
  func getCarsListData(completion: @escaping (_ result: Result<[CarListItemDataView], CarsFetcherError>) -> Void)
}

struct CarsListFetcher: CarsListFetcherProtocol
{
  let restClient: RestClientProtocol

  init(restClient: RestClientProtocol)
  {
    self.restClient = restClient
  }

  func getCarsLocationData(completion: @escaping (_ result: Result<[CarLocationViewData], CarsFetcherError>) -> Void)
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

  func getCarsListData(completion: @escaping (_ result: Result<[CarListItemDataView], CarsFetcherError>) -> Void)
  {
    restClient.getCarsList(completion: { result in
      switch result
      {
      case .success(let response):
        let result = self.handleResponseForListViewData(response: response)
        completion(result)
      case .failure:
        completion(.failure(.emptyList))
      }
    })
  }

  private func handleResponseForListViewData(response: CarsList) -> Result<[CarListItemDataView], CarsFetcherError>
  {
    let filtered = response.filter(self.validateResponseItemForListItem)
    if filtered.isEmpty
    {
      return .failure(.emptyList)
    }
    return .success(self.createViewDataForItemList(carList: filtered))
  }

  private func validateResponseItemForListItem(carItem: CarsListElement) -> Bool
  {
    return carItem.modelName != nil && carItem.fuelType != nil && carItem.transmission != nil
      && carItem.carImageURL != nil
  }

  private func createViewDataForItemList(carList: CarsList) -> [CarListItemDataView]
  {
    return carList.map { (carItem: CarsListElement) -> CarListItemDataView in
      guard let modelName = carItem.modelName, let fuelType = carItem.fuelType,
        let transmission = carItem.transmission?.rawValue,
        let imgUrl = carItem.carImageURL else {
        fatalError("Items here should already be filtered")
      }

      let fuelTypeViewData = createFuleDescription(fuelType: fuelType)
      return CarListItemDataView(imageUrl: imgUrl,
                                 modelName: modelName,
                                 transmission: transmission,
                                 fuelType: fuelTypeViewData)
    }
  }

  private func createFuleDescription(fuelType: FuelType) -> FuelTypeViewData
  {
    switch fuelType
    {
    case .diesel:
      return .diesel
    case .electrical:
      return .electrical
    case .petrol:
      return .gasoline
    }
  }

}
