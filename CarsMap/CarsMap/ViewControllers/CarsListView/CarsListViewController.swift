//
//  CarsListViewController.swift
//  CarsMap
//
//  Created by Antonio Ruffolo on 13/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import UIKit
import SDWebImage

protocol ReloadItems: class
{
  func reloadItems()
}

protocol CarsListViewProtocol where Self: UIViewController
{
  func close()
  func elementHasBeenTappedAt(index: Int)
}

class CarsListViewController: UIViewController, CarsListViewProtocol
{
  @IBOutlet weak var tableView: UITableView!

  var closeClosure: (() -> Void)?
  var didTapIndexClosure: ((_ index: Int) -> Void)?

  var itemDataView: [CarListItemDataView] = []
  var dataSource: CarsListDataSource!
  var tableDelegate: CarListDelegate!
  var viewModel: CarsListViewModelProtocol!

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

    setTableDelegateAndSource()

    navigationController?.isNavigationBarHidden = false
    navigationController?.navigationBar.tintColor = UIColor.purple

    setBackButton()
  }

  private func setTableDelegateAndSource()
  {
    dataSource = CarsListDataSource(reloadTable: self)
    tableView.dataSource = dataSource

    tableDelegate = CarListDelegate()
    tableDelegate.didTapIndexClosure = { [weak self] index in
      self?.viewModel.didTapElementAt(index: index)
    }

    tableView.delegate = tableDelegate
  }

  private func setBackButton()
  {
    let item = UIBarButtonItem(title: AppStrings.back.value,
                               style: .plain,
                               target: self,
                               action: #selector(goBackTapped))
    navigationItem.hidesBackButton = true
    navigationItem.leftBarButtonItem = item
  }

  override func viewWillAppear(_ animated: Bool)
  {
    super.viewWillAppear(animated)
    dataSource.itemDataView = itemDataView
  }

  @objc private func goBackTapped()
  {
    viewModel.goBackTapped()
  }

  func close()
  {
    closeClosure?()
  }

  func elementHasBeenTappedAt(index: Int)
  {
    self.didTapIndexClosure?(index)
  }

  deinit
  {
    print("view controller: \(CarsListViewController.self.description()) deinit called")
  }
}

extension CarsListViewController: ReloadItems
{
  func reloadItems()
  {
    tableView.reloadData()
  }
}

class CarsListDataSource: NSObject, UITableViewDataSource
{
  weak var reloadTable: ReloadItems?

  var itemDataView: [CarListItemDataView]? {
    didSet {
      reloadTable?.reloadItems()
    }
  }

  init(reloadTable: ReloadItems)
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

    if let item = itemDataView?[indexPath.row]
    {
      cell.carmodelNameLabel.text = item.modelName
      cell.carTransmissionLabel.text = item.transmission
      cell.fuelTypeLabel.text = item.fuelType.rawValue
      cell.carImageView.sd_setImage(with: URL(string: item.imageUrl),
                                    placeholderImage: UIImage(named: "carPlaceholder"))
    }

    return cell
  }
}

class CarListDelegate: NSObject, UITableViewDelegate
{
  var didTapIndexClosure: ((_ index: Int) -> Void)?

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
  {
    didTapIndexClosure?(indexPath.row)
  }
}
