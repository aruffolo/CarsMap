//
//  CarCollectionViewCell.swift
//  CarsMap
//
//  Created by Antonio Ruffolo on 14/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import UIKit

class CarCollectionViewCell: UICollectionViewCell
{
  static var identifier: String = "CarCollectionViewCell"

  @IBOutlet weak var shadowView: UIView!
  @IBOutlet weak var carImageView: UIImageView!
  @IBOutlet weak var carModelNameLabel: UILabel!
  @IBOutlet weak var carTransmissionLabel: UILabel!
  @IBOutlet weak var carFuelLabel: UILabel!

  override func awakeFromNib()
  {
    super.awakeFromNib()

    shadowView.layer.cornerRadius = 15
    shadowView.layer.masksToBounds = false
    setShadow(layer: shadowView.layer)
  }

  private func setShadow(layer: CALayer)
  {
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.4
    layer.shadowRadius = 4.0
    layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
  }
}
