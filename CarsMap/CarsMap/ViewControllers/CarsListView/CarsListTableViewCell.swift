//
//  CarsListTableViewCell.swift
//  CarsMap
//
//  Created by Antonio Ruffolo on 13/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import UIKit

class CarsListTableViewCell: UITableViewCell
{
  @IBOutlet weak var carmodelNameLabel: UILabel!
  @IBOutlet weak var carTransmissionLabel: UILabel!
  @IBOutlet weak var carImageView: UIImageView!
  @IBOutlet weak var fuelTypeLabel: UILabel!

  static let reuseIdentifier: String = "CarsListTableViewCell"
  
  override func awakeFromNib()
  {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool)
  {
    super.setSelected(selected, animated: animated)
  }
}
