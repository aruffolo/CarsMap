//
//  CarsListViewController.swift
//  CarsMap
//
//  Created by Antonio Ruffolo on 13/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import UIKit

protocol ReloadTable: class
{
  func reloadTable()
}

class CarsListViewController: UIViewController
{
  @IBOutlet weak var tableView: UITableView!

  var itemDataView: [CarListItemDataView] = []
  var dataSource: CarsListDataSource!

  static func initViewController(itemDataView: [CarListItemDataView]) -> CarsListViewController
  {
    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
    guard let vc = storyboard.instantiateViewController(withIdentifier: "CarsListViewController")
      as? CarsListViewController else {
        fatalError("This must be a CarsListViewController")
    }
    
    vc.itemDataView = itemDataView

    return vc
  }

  override func viewDidLoad()
  {
    super.viewDidLoad()

    dataSource = CarsListDataSource(reloadTable: self)
    tableView.dataSource = dataSource

    navigationController?.isNavigationBarHidden = false
  }

  override func viewWillAppear(_ animated: Bool)
  {
    super.viewWillAppear(animated)
    dataSource.itemDataView = itemDataView
  }

  override func viewWillDisappear(_ animated: Bool)
  {
    super.viewWillDisappear(animated)
    navigationController?.isNavigationBarHidden = false
  }
}

extension CarsListViewController: ReloadTable
{
  func reloadTable()
  {
    tableView.reloadData()
  }
}

class CarsListDataSource: NSObject, UITableViewDataSource
{
  weak var reloadTable: ReloadTable?

  var itemDataView: [CarListItemDataView]? {
    didSet {
      reloadTable?.reloadTable()
    }
  }

  init(reloadTable: ReloadTable)
  {
    self.reloadTable = reloadTable
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return itemDataView?.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: CarsListTableViewCell.reuseIdentifier,
                                                   for: indexPath) as? CarsListTableViewCell else {
        fatalError("cell must be present CarsListTableViewCell")
    }

    if let item = itemDataView?[indexPath.row] {
      cell.carmodelNameLabel.text = item.modelName
      cell.carTransmissionLabel.text = item.transmission
      cell.fuelTypeLabel.text = item.fuelType.rawValue
    }

    return cell
  }
}
