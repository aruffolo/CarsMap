//
//  CarClusterAnnotationView.swift
//  CarsMap
//
//  Created by Antonio Ruffolo on 13/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import UIKit
import MapKit

class CarClusterAnnotationView: MKAnnotationView
{
  internal override var annotation: MKAnnotation? { willSet { newValue.flatMap(configure(with:)) } }

  override init(annotation: MKAnnotation?, reuseIdentifier: String?)
  {
    super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    displayPriority = .defaultHigh
    collisionMode = .circle
    centerOffset = CGPoint(x: 0.0, y: -10.0)
  }

  required init(coder aDecoder: NSCoder)
  {
    fatalError("not implemented")
  }
}

private extension CarClusterAnnotationView
{
  func configure(with annotation: MKAnnotation)
  {
    guard let annotation = annotation as? MKClusterAnnotation else { return }

    let renderer = UIGraphicsImageRenderer(size: CGSize(width: 40.0, height: 40.0))
    let count = annotation.memberAnnotations.count

    image = renderer.image { _ in
      UIColor.purple.setFill()

      UIBezierPath(ovalIn: CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)).fill()
      let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                        NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20.0)]

      let text = "\(count)"
      let size = text.size(withAttributes: attributes)
      let rect = CGRect(x: 20 - size.width / 2, y: 20 - size.height / 2,
                        width: size.width,
                        height: size.height)
      text.draw(in: rect, withAttributes: attributes)
    }
  }
}
