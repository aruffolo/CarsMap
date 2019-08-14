//
//  AppStrings.swift
//  CarsMap
//
//  Created by Antonio Ruffolo on 14/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation

enum AppStrings: String
{
  case error = "error_key"
  case serviceUnavailable = "service_unvailable"
  case close = "close"
  case dataNotFound = "data_not_found"
  case back = "back"
  case retry = "retry"
  case locationNotFound = "location_not_found"

  var value: String {
    let v = NSLocalizedString(self.rawValue, tableName: "AppMessages", comment: "")
    return v
  }
}
