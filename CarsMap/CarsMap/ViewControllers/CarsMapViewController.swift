//
//  CarsMapViewController.swift
//  CarsMap
//
//  Created by Antonio Ruffolo on 13/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import UIKit
import MapKit

protocol CarsMapViewProtocol where Self: UIViewController
{
  func zoomToLocation(coordinate: (lat: Double, lng: Double))
  func addPoisToMap(carsViewData: [CarLocationViewData])
}

class CarsMapViewController: UIViewController
{
  @IBOutlet weak var mapView: MKMapView!

  var viewModel: CarsMapViewModelProtocol?

  override func viewDidLoad()
  {
    super.viewDidLoad()
    setStyle()
    setMapSettings()
  }

  private func setStyle()
  {
    navigationController?.isNavigationBarHidden = true
    mapView.showsUserLocation = true
  }

  private func setMapSettings()
  {
    mapView.register(CarAnnotationView.self,
                     forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)

    mapView.register(CarClusterAnnotationView.self,
                     forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
  }

  override func viewWillAppear(_ animated: Bool)
  {
    super.viewWillAppear(false)
    viewModel?.viewIsReady()
  }
}

extension CarsMapViewController: CarsMapViewProtocol
{

  func zoomToLocation(coordinate: (lat: Double, lng: Double))
  {
    let coor = CLLocationCoordinate2D(latitude: coordinate.lat, longitude: coordinate.lng)
    centerMapOnLocation(coordinate: coor)
  }

  private func centerMapOnLocation(coordinate: CLLocationCoordinate2D)
  {
    guard CLLocationCoordinate2DIsValid(coordinate) else { return }
    let regionRadius: CLLocationDistance = 1000
    let coordinateRegion = MKCoordinateRegion(center: coordinate,
                                              latitudinalMeters: regionRadius,
                                              longitudinalMeters: regionRadius)
    mapView.setRegion(coordinateRegion, animated: true)
  }

  func addPoisToMap(carsViewData: [CarLocationViewData])
  {
    let annotations = carsViewData.map { (data: CarLocationViewData) -> CarMapAnnotation in
      let annotation = CarMapAnnotation(coordinate: CLLocationCoordinate2D(latitude: data.lat, longitude: data.lng))
      return annotation
    }
    mapView.addAnnotations(annotations)
  }
}
