//
//  CarLocationViewData.swift
//  CarsMap
//
//  Created by Antonio Ruffolo on 13/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation

protocol DataId
{
  var dataId: String { get }
}

struct CarLocationViewData: DataId
{
  let lat: Double
  let lng: Double

  let name: String

  var dataId: String
}
