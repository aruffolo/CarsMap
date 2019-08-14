//
//  CarsCollectionViewController.swift
//  CarsMap
//
//  Created by Antonio Ruffolo on 14/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import UIKit

protocol CardCollectionProtocol where Self: UIViewController
{
  var itemTappedAtIndex:((_ index: Int) -> Void)? { get set }
  func updateCarsData(itemDataView: [CarListItemDataView])
  func scrollToItemAt(index: Int)
}

class CarsCollectionViewController: UIViewController, CardCollectionProtocol
{
  @IBOutlet weak var collectionView: UICollectionView!

  var itemTappedAtIndex: ((Int) -> Void)?
  var dataSource: CardCollectionViewSource?
  var collectionFlowDelegate: CardCollectionViewDelegate?

  static func initViewController() -> CarsCollectionViewController
  {
    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
    guard let vc = storyboard.instantiateViewController(withIdentifier: "CarsCollectionViewController")
      as? CarsCollectionViewController else {
        fatalError("This must be a CarsCollectionViewController")
    }

    return vc
  }

  override func viewDidLoad()
  {
    super.viewDidLoad()
    setCollectionView()
  }

  private func setCollectionView()
  {
    dataSource = CardCollectionViewSource()
    collectionView.dataSource = dataSource
    dataSource?.reloadTable = self

    collectionFlowDelegate = CardCollectionViewDelegate()
    collectionView.delegate = collectionFlowDelegate

    collectionFlowDelegate?.itemTappedAtIndex = { [weak self] index in
      self?.itemTappedAtIndex?(index)
    }
  }

  func updateCarsData(itemDataView: [CarListItemDataView])
  {
    dataSource?.itemDataView = itemDataView
    collectionFlowDelegate?.itemDataView = itemDataView
  }

  func scrollToItemAt(index: Int)
  {
    collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
  }
}

extension CarsCollectionViewController: ReloadItems
{
  func reloadItems()
  {
    collectionView.reloadData()
  }
}

class CardCollectionViewSource: NSObject, UICollectionViewDataSource
{
  weak var reloadTable: ReloadItems?

  var itemDataView: [CarListItemDataView]? {
    didSet {
      reloadTable?.reloadItems()
    }
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return itemDataView?.count ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
  {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarCollectionViewCell.identifier,
                                                        for: indexPath) as? CarCollectionViewCell,
      let item = itemDataView?[indexPath.row] else {
        fatalError("the cell dequeued must be of type CarCollectionViewCell")
    }

    cell.carModelNameLabel.text = item.modelName
    cell.carTransmissionLabel.text = item.transmission
    cell.carFuelLabel.text = item.fuelType.rawValue
    cell.carImageView.sd_setImage(with: URL(string: item.imageUrl),
                                  placeholderImage: UIImage(named: "carPlaceholder"))
    return cell
  }
}

class CardCollectionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout
{
  var itemDataView: [CarListItemDataView]?

  let horizontalMargin: CGFloat = 0
  let itemSpacing: CGFloat = 20
  let itemHeight: CGFloat = 250
  let itemWidth: CGFloat = 380

  var itemTappedAtIndex: ((Int) -> Void)?

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
  {
    itemTappedAtIndex?(indexPath.row)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize
  {

    return CGSize(width: itemWidth, height: itemHeight)
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets
  {

    return UIEdgeInsets(top: 0, left: horizontalMargin, bottom: 0, right: horizontalMargin)
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat
  {
    return  0
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
  {
    return  itemSpacing / 2
  }

  func collectionView(_ collectionView: UICollectionView,
                      willDisplay cell: UICollectionViewCell,
                      forItemAt indexPath: IndexPath)
  {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
      CarCollectionViewCell.identifier, for: indexPath) as? CarCollectionViewCell,
      let item = itemDataView?[indexPath.row] else {
        return
    }

    cell.carModelNameLabel.text = item.modelName
    cell.carTransmissionLabel.text = item.transmission
    cell.carFuelLabel.text = item.fuelType.rawValue
    cell.carImageView.sd_setImage(with: URL(string: item.imageUrl),
                                  placeholderImage: UIImage(named: "carPlaceholder"))
  }
}
