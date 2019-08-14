//
//  CarsMapViewModel.swift
//  CarsMap
//
//  Created by Antonio Ruffolo on 13/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation

protocol LocationManagerDelegate: class
{
  func didUpdateLocation(coordinate: (lat: Double, lng: Double))
  func didFail()
}

protocol CarsMapViewModelProtocol
{
  func viewIsReady()
  func ceterButtonTapped()
  func goToListTapped()
  func zoomToCarLocationView(indexOfCardListItem: Int)
  func annotationTapped(carId: String)
  func loadData()
}

class CarsMapViewModel: CarsMapViewModelProtocol
{
  weak var view: CarsMapViewProtocol?
  let locationManager: CarsLocationManagerProtocol
  let carsFetcher: CarsListFetcherProtocol

  var carsLocationViewData: [CarLocationViewData]?
  var carsListViewData: [CarListItemDataView]?

  init(view: CarsMapViewProtocol?,
       locationManager: CarsLocationManagerProtocol,
       carsFetcher: CarsListFetcherProtocol)
  {
    self.view = view
    self.locationManager = locationManager
    self.carsFetcher = carsFetcher
  }

  func viewIsReady()
  {
    locationManager.requestAutorization()
    loadData()
  }

  func loadData()
  {
    carsFetcher.getCarsLocationData(completion: { [weak self] result in
      switch result
      {
      case .success(let list):
        self?.carsLocationViewData = list
        self?.view?.addPoisToMap(carsViewData: list)
        let coordinate = (lat: list.first!.lat, lng: list.first!.lng)
        self?.view?.zoomToLocation(coordinate: coordinate)
      case .failure(let error):
        self?.showError(error: error)
      }
    })

    getCarListData(completion: { [weak self] list in
      self?.view?.fillCollectionView(carsItemData: list)
    })
  }

  func ceterButtonTapped()
  {
    locationManager.requestLocation()
  }

  func goToListTapped()
  {
    getCarListData(completion: { [weak self] list in
      self?.view?.goTolist(carsItemData: list)
    })
  }

  private func getCarListData(completion: @escaping ((_ itemList: [CarListItemDataView]) -> Void))
  {
    carsFetcher.getCarsListData(completion: { [weak self] result in
      switch result
      {
      case .success(let list):
        self?.carsListViewData = list
        completion(list)
      case .failure(let error):
        self?.showError(error: error)
      }
    })
  }

  private func showError(error: CarsFetcherError)
  {
    switch error
    {
    case .serviceUnavailable:
      view?.showErrorForDataFailure(title: AppStrings.error.value,
                      message: AppStrings.serviceUnavailable.value,
                      buttonLabel: AppStrings.retry.value)
    case .emptyList:
      view?.showErrorForDataFailure(title: AppStrings.error.value,
                      message: AppStrings.dataNotFound.value,
                      buttonLabel: AppStrings.retry.value)
    }
  }

  func zoomToCarLocationView(indexOfCardListItem: Int)
  {
    let index = carsLocationViewData?.firstIndex(where: {
      $0.dataId == self.carsListViewData?[indexOfCardListItem].dataId
    })

    if let indexFound = index, let data = carsLocationViewData?[indexFound]
    {
      self.view?.zoomToLocation(coordinate: (lat: data.lat, lng: data.lng))
    }
  }

  func annotationTapped(carId: String)
  {
    let dataIndex = carsLocationViewData?.firstIndex(where: {
      $0.dataId == carId
    })

    if let index = dataIndex
    {
      view?.scrollCollectionTo(index: index)
    }
  }
}

extension CarsMapViewModel: LocationManagerDelegate
{
  func didUpdateLocation(coordinate: (lat: Double, lng: Double))
  {
    // todo zoom to location
    view?.zoomToLocation(coordinate: coordinate)
  }

  func didFail()
  {
    // show error
  }
}
