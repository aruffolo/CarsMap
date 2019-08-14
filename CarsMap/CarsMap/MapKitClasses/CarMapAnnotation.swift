//
//  CarMapAnnotation.swift
//  CarsMap
//
//  Created by Antonio Ruffolo on 13/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import MapKit

final class CarMapAnnotation: NSObject, MKAnnotation
{
  let coordinate: CLLocationCoordinate2D
  let imageName: String
  let carId: String

  init(coordinate: CLLocationCoordinate2D, carId: String)
  {
    self.coordinate = coordinate
    self.carId = carId
    imageName = "carIcon"
  }
}
