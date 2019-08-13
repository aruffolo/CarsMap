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
}

class CarsMapViewModel: CarsMapViewModelProtocol
{
  weak var view: CarsMapViewProtocol?
  let locationManager: CarsLocationManagerProtocol
  let carsFetcher: CarsListFetcherProtocol

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
    locationManager.requestLocation()

    carsFetcher.getCarsList(completion: { result in
      switch result
      {
      case .success(let list):
        // TODO
        break
      case .failure(let error):
        // TODO: set errors to show
        break
      }
    })
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
