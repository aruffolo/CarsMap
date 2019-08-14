//
//  Constants.swift
//  CarsMapTests
//
//  Created by Antonio Ruffolo on 14/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation
@testable import CarsMap

struct Constants
{
  static let carListResponse: [CarsListElement] = [
    CarsListElement(carId: "a",
                    modelIdentifier: "",
                    modelName: "FIAT 500",
                    name: "",
                    make: "",
                    group: "FIAT",
                    color: "",
                    series: "",
                    fuelType: .gasoline,
                    fuelLevel: 0.5,
                    transmission: .manual,
                    licensePlate: "",
                    latitude: 48.134557,
                    longitude: 11.576921,
                    innerCleanliness: .clean,
                    carImageURL: "https://cdn.sixt.io/codingtask/images/mini.png"),
    CarsListElement(carId: "b",
                    modelIdentifier: "",
                    modelName: "FIAT 500",
                    name: "",
                    make: "",
                    group: "FIAT",
                    color: "",
                    series: "",
                    fuelType: .gasoline,
                    fuelLevel: 0.5,
                    transmission: .manual,
                    licensePlate: "",
                    latitude: 48.114988,
                    longitude: 11.598359,
                    innerCleanliness: .clean,
                    carImageURL: "https://cdn.sixt.io/codingtask/images/mini.png"),
    CarsListElement(carId: "c",
                    modelIdentifier: "",
                    modelName: "Ferrari Enzo",
                    name: "",
                    make: "",
                    group: "FIAT",
                    color: "",
                    series: "",
                    fuelType: .gasoline,
                    fuelLevel: 0.5,
                    transmission: .manual,
                    licensePlate: "",
                    latitude: 48.152207,
                    longitude: 11.572649,
                    innerCleanliness: .clean,
                    carImageURL: "https://cdn.sixt.io/codingtask/images/mini.png")
  ]

  static let carLocationList: [CarLocationViewData] = [
    CarLocationViewData(lat: 48.134557, lng: 11.576921, name: "FIAT 500", dataId: "a"),
    CarLocationViewData(lat: 48.114988, lng: 11.598359, name: "FIAT 500", dataId: "b"),
    CarLocationViewData(lat: 48.152207, lng: 11.572649, name: "Ferrari Enzo", dataId: "c")
  ]

  static let carListViewData: [CarListItemDataView] = [
    CarListItemDataView(imageUrl: "https://cdn.sixt.io/codingtask/images/mini.png",
                        modelName: "FIAT 500",
                        transmission: "manual",
                        fuelType: .gasoline,
                        dataId: "a"),
    CarListItemDataView(imageUrl: "https://cdn.sixt.io/codingtask/images/mini.png",
                        modelName: "FIAT 500",
                        transmission: "manual",
                        fuelType: .gasoline,
                        dataId: "b"),
    CarListItemDataView(imageUrl: "https://cdn.sixt.io/codingtask/images/mini.png",
                        modelName: "Ferrari Enzo",
                        transmission: "manual",
                        fuelType: .gasoline,
                        dataId: "c")
  ]

}
