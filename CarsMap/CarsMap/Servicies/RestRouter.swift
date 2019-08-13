//
//  RestRouter.swift
//  CarsMap
//
//  Created by Antonio Ruffolo on 13/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation
import Alamofire

private enum Constants
{
  static let baseURLPath = "https://cdn.sixt.io/codingtask"
}

private enum EndPoints: String
{
  case cars = "/cars"
}

public enum RestRouter: URLRequestConvertible
{
  case cars

  var method: HTTPMethod
  {
    switch self
    {
    case .cars:
      return .get
    }
  }

  var path: String
  {
    switch self
    {
    case .cars:
      return EndPoints.cars.rawValue
    }
  }

  var parameters: Parameters?
  {
    switch self
    {
    case .cars:
      return nil
    }
  }

  var encoding: ParameterEncoding
  {
    switch method
    {
    case .get:
      return URLEncoding.default
    default:
      return JSONEncoding.default
    }
  }

  public func asURLRequest() throws -> URLRequest
  {
    let url = try Constants.baseURLPath.asURL()
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))

    // HTTP Method
    urlRequest.httpMethod = method.rawValue

    // Common Headers
    urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)

    if method == .post
    {
      return try createPostUrlRequest(urlRequest: &urlRequest)
    }
    else
    {
      let finalRequest = try encoding.encode(urlRequest, with: parameters)
      print("GET request url\n: \(String(describing: finalRequest.url?.absoluteString))")
      return finalRequest
    }
  }

  private func createPostUrlRequest(urlRequest: inout URLRequest) throws -> URLRequest
  {
    if let parameters = parameters
    {
      do
      {
        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
      }
      catch
      {
        throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
      }
    }
    return urlRequest
  }
}
