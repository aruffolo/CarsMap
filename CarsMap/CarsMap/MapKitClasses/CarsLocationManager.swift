//
//  CarsLocationManager.swift
//  CarsMap
//
//  Created by Antonio Ruffolo on 13/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation
import MapKit

protocol CarsLocationManagerProtocol
{
  func requestAutorization()
  func requestLocation()
}

class CarsLocationManager: NSObject, CarsLocationManagerProtocol
{
  let manager = CLLocationManager()
  weak var delegate: LocationManagerDelegate?

  override init() {
    super.init()
    manager.delegate = self
  }

  func requestAutorization()
  {
    manager.requestWhenInUseAuthorization()
  }

  func requestLocation()
  {
    manager.requestLocation()
  }
}

extension CarsLocationManager: CLLocationManagerDelegate
{
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
  {
    if let location = locations.first
    {
      print("Found user's location: \(location)")
      delegate?.didUpdateLocation(coordinate: (lat: location.coordinate.latitude, lng: location.coordinate.longitude))
    }
  }

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Failed to find user's location: \(error.localizedDescription)")
  }
}
