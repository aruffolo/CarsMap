//
//  CarsMapViewModel.swift
//  CarsMap
//
//  Created by Antonio Ruffolo on 13/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation

protocol LocationManagerDelegate: class
{
  func didUpdateLocation(coordinate: (lat: Double, lng: Double))
  func didFail()
}

protocol CarsMapViewModelProtocol
{
  func viewIsReady()
  func ceterButtonTapped()
  func goToListTapped()
  func zoomToCarLocationView(indexOfCardListItem: Int)
}

class CarsMapViewModel: CarsMapViewModelProtocol
{
  weak var view: CarsMapViewProtocol?
  let locationManager: CarsLocationManagerProtocol
  let carsFetcher: CarsListFetcherProtocol

  var carsLocationViewData: [CarLocationViewData]?
  var carsListViewData: [CarListItemDataView]?

  init(view: CarsMapViewProtocol?,
       locationManager: CarsLocationManagerProtocol,
       carsFetcher: CarsListFetcherProtocol)
  {
    self.view = view
    self.locationManager = locationManager
    self.carsFetcher = carsFetcher
  }

  func viewIsReady()
  {
    locationManager.requestAutorization()

    carsFetcher.getCarsLocationData(completion: { result in
      switch result
      {
      case .success(let list):
        self.carsLocationViewData = list
        self.view?.addPoisToMap(carsViewData: list)
        let coordinate = (lat: list.first!.lat, lng: list.first!.lng)
        self.view?.zoomToLocation(coordinate: coordinate)
      case .failure(let error):
        // TODO: set errors to show
        break
      }
    })
  }

  func ceterButtonTapped()
  {
    locationManager.requestLocation()
  }

  func goToListTapped()
  {
    carsFetcher.getCarsListData(completion: { result in
      switch result
      {
      case .success(let list):
        self.carsListViewData = list
        self.view?.goTolist(carsItemData: list)
      case .failure(let error):
        // TODO: set errors to show
        break
      }
    })
  }

  func zoomToCarLocationView(indexOfCardListItem: Int)
  {
    let index = carsLocationViewData?.firstIndex(where: {
      $0.dataId == self.carsListViewData?[indexOfCardListItem].dataId
    })

    if let indexFound = index, let data = carsLocationViewData?[indexFound]
    {
      self.view?.zoomToLocation(coordinate: (lat: data.lat, lng: data.lng))
    }
  }
}

extension CarsMapViewModel: LocationManagerDelegate
{
  func didUpdateLocation(coordinate: (lat: Double, lng: Double))
  {
    // todo zoom to location
    view?.zoomToLocation(coordinate: coordinate)
  }

  func didFail()
  {
    // show error
  }
}
