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
  func goTolist(carsItemData: [CarListItemDataView])
}

class CarsMapViewController: UIViewController
{
  @IBOutlet weak var centerButton: UIButton!
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var carsListButton: UIButton!

  var goToListClosure: ((_ carsItemData: [CarListItemDataView]) -> Void)?

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

    centerButton.layer.cornerRadius = centerButton.frame.width / 2
    setShadow(layer: centerButton.layer)

    carsListButton.layer.cornerRadius = 5
    setShadow(layer: carsListButton.layer)
  }

  private func setShadow(layer: CALayer)
  {
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.4
    layer.shadowRadius = 4.0
    layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
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
    navigationController?.isNavigationBarHidden = true
  }

  func elementHasBeenTappedAt(index: Int)
  {
    self.viewModel?.zoomToCarLocationView(indexOfCardListItem: index)
  }

  @IBAction func centerButtonTapped(_ sender: UIButton)
  {
    viewModel?.ceterButtonTapped()
  }

  @IBAction func carsListButtonTapped(_ sender: UIButton)
  {
    viewModel?.goToListTapped()
  }

  func goToListTapped()
  {
    viewModel?.goToListTapped()
  }

  func goTolist(carsItemData: [CarListItemDataView])
  {
    goToListClosure?(carsItemData)
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

    DispatchQueue.main.async {
      self.mapView.removeAnnotations(self.mapView.annotations)
      self.mapView.addAnnotations(annotations)
    }
  }
}
