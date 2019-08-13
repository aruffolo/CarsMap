//
//  CarAnnotationView.swift
//  CarsMap
//
//  Created by Antonio Ruffolo on 13/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import UIKit
import MapKit

class CarAnnotationView: MKAnnotationView
{
  internal override var annotation: MKAnnotation?
  {
    willSet
    {
      newValue.flatMap(configure(with:))
    }
  }
}

private extension CarAnnotationView
{
  func configure(with annotation: MKAnnotation)
  {
    guard annotation is CarMapAnnotation else {
      fatalError("Unexpected annotation type: \(annotation)")
    }

    let pinImage = UIImage(named: "carIcon.png")
    let size = CGSize(width: 30, height: 30)
    UIGraphicsBeginImageContext(size)
    pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
    let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
    self.image = resizedImage

    clusteringIdentifier = String(describing: CarAnnotationView.self)
  }
}
