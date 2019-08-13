//
//  CarsMapViewModel.swift
//  CarsMap
//
//  Created by Antonio Ruffolo on 13/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation

protocol LocationManagerDelegate where Self: AnyObject
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

  init(view: CarsMapViewProtocol?, locationManager: CarsLocationManagerProtocol)
  {
    self.view = view
    self.locationManager = locationManager
  }

  func viewIsReady()
  {
    locationManager.requestAutorization()
    locationManager.requestLocation()
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
