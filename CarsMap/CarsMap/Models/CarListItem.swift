//
//  CarListItem.swift
//  CarsMap
//
//  Created by Antonio Ruffolo on 13/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation

enum FuelTypeViewData: String {
  case diesel = "Diesel"
  case gasoline = "Gasoline"
  case electrical = "Electrical"
}

struct CarListItemDataView
{
  let imageUrl: String
  let modelName: String
  let transmission: String
  let fuelType: FuelTypeViewData
}
