//
//  RestClientMock.swift
//  CarsMapTests
//
//  Created by Antonio Ruffolo on 14/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation
@testable import CarsMap
@testable import Alamofire

class RestClientMock: RestClientProtocol
{
  var failure: Bool = false
  var returnEmpty: Bool = false

  func getCarsList(completion: @escaping (AFResult<CarsList>) -> Void)
  {
    if returnEmpty
    {
      completion(AFResult.success([]))
    }
    else if failure
    {
      completion(.failure(BackendError.parsing(reason: "")))
    }
    else
    {
      completion(AFResult.success(Constants.carListResponse))
    }
  }
}
