//
//  CarListMockViewController.swift
//  CarsMapTests
//
//  Created by Antonio Ruffolo on 14/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import UIKit
@testable import CarsMap

class CarListMockViewController: UIViewController, CarsListViewProtocol
{
  var indexTapped: Int?

  override func viewDidLoad()
  {
    super.viewDidLoad()
  }

  func elementHasBeenTappedAt(index: Int)
  {
    self.indexTapped = index
  }

  func close()
  {
    // nothing to do here
  }
}
