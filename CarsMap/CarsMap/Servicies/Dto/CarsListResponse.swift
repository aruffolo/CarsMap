//
//  CarsListResponse.swift
//  CarsMap
//
//  Created by Antonio Ruffolo on 13/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation

struct CarsListElement: Codable
{
  let carId, modelIdentifier, modelName, name: String?
  let make, group: String?
  let color, series: String?
  let fuelType: FuelType?
  let fuelLevel: Double?
  let transmission: Transmission?
  let licensePlate: String?
  let latitude, longitude: Double?
  let innerCleanliness: InnerCleanliness?
  let carImageURL: String?

  enum CodingKeys: String, CodingKey
  {
    case modelIdentifier, modelName, name, make, group, color, series, fuelType, fuelLevel, transmission,
    licensePlate, latitude, longitude, innerCleanliness
    case carImageURL = "carImageUrl"
    case carId = "id"
  }
}

enum FuelType: String, Codable
{
  case diesel = "D"
  case electrical = "E"
  case gasoline = "P"
}

enum InnerCleanliness: String, Codable
{
  case clean = "CLEAN"
  case regular = "REGULAR"
  case veryClean = "VERY_CLEAN"
}

enum Transmission: String, Codable
{
  case automatic = "A"
  case manual = "M"
}

typealias CarsList = [CarsListElement]
