//
//  RestConstants.swift
//  CarsMap
//
//  Created by Antonio Ruffolo on 13/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation

enum HTTPHeaderField: String
{
  case authentication = "Authorization"
  case contentType = "Content-Type"
  case acceptType = "Accept"
  case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String
{
  case json = "application/json"
}
