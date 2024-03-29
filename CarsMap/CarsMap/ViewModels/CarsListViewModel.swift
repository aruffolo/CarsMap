//
//  CarsListViewModel.swift
//  CarsMap
//
//  Created by Antonio Ruffolo on 13/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import Foundation

protocol CarsListViewModelProtocol
{
  func goBackTapped()
  func didTapElementAt(index: Int)
}

class CarsListViewModel: CarsListViewModelProtocol
{
  weak var view: CarsListViewProtocol?

  init(view: CarsListViewProtocol)
  {
    self.view = view
  }

  func goBackTapped()
  {
    view?.close()
  }

  func didTapElementAt(index: Int)
  {
    view?.elementHasBeenTappedAt(index: index)
  }
}
