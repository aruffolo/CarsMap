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
  func showErrorForDataFailure(title: String, message: String, buttonLabel: String)
  func showError(title: String, message: String, buttonLabel: String)
  func fillCollectionView(carsItemData: [CarListItemDataView])
  func scrollCollectionTo(index: Int)
}

class CarsMapViewController: UIViewController
{
  @IBOutlet weak var shadowView: UIView!
  @IBOutlet weak var centerButton: UIButton!
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var carsListButton: UIButton!
  @IBOutlet weak var containerView: UIView!
  
  var mapViewDelegate: CarsMapViewDelegate!

  var goToListClosure: ((_ carsItemData: [CarListItemDataView]) -> Void)?

  var viewModel: CarsMapViewModelProtocol?
  var strongCollectionViewController: CardCollectionProtocol?
  weak var collectionViewController: CardCollectionProtocol?

  override func viewDidLoad()
  {
    super.viewDidLoad()
    setStyle()
    setMapSettings()
    addCollectionViewController()
    
    viewModel?.viewIsReady()
  }

  private func setStyle()
  {
    navigationController?.isNavigationBarHidden = true
    mapView.showsUserLocation = true

    centerButton.layer.cornerRadius = centerButton.frame.width / 2
    setShadow(layer: centerButton.layer)

    carsListButton.layer.cornerRadius = 5
    setShadow(layer: carsListButton.layer)
    setShadow(layer: shadowView.layer)
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

    mapViewDelegate = CarsMapViewDelegate()
    mapViewDelegate.didSelectId = { [weak self] carId in

      self?.viewModel?.annotationTapped(carId: carId)
    }

    mapView.delegate = mapViewDelegate
  }

  override func viewWillAppear(_ animated: Bool)
  {
    super.viewWillAppear(false)
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

  private func addCollectionViewController()
  {
    if let collectionViewController = self.strongCollectionViewController
    {
      self.collectionViewController = collectionViewController
      self.addChild(collectionViewController)
      collectionViewController.view.frame = self.containerView.bounds
      self.containerView.addSubview(collectionViewController.view)
      collectionViewController.didMove(toParent: self)

      strongCollectionViewController = nil
    }
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
      let annotation = CarMapAnnotation(coordinate: CLLocationCoordinate2D(latitude: data.lat, longitude: data.lng),
                                        carId: data.dataId)
      return annotation
    }

    DispatchQueue.main.async {
      self.mapView.removeAnnotations(self.mapView.annotations)
      self.mapView.addAnnotations(annotations)
    }
  }
  
  func showErrorForDataFailure(title: String, message: String, buttonLabel: String)
  {
    let alertController = UIAlertController(title: title, message:
      message, preferredStyle: UIAlertController.Style.alert)

    alertController.addAction(UIAlertAction(title: buttonLabel,
                                            style: UIAlertAction.Style.default, handler: { [weak self] _ in
                                              self?.viewModel?.loadData()
    }))

    self.present(alertController, animated: true, completion: nil)
  }

  func showError(title: String, message: String, buttonLabel: String)
  {
    let alertController = UIAlertController(title: title, message:
      message, preferredStyle: UIAlertController.Style.alert)
    alertController.addAction(UIAlertAction(title: buttonLabel, style: UIAlertAction.Style.default, handler: nil))

    self.present(alertController, animated: true, completion: nil)
  }

  func goTolist(carsItemData: [CarListItemDataView])
  {
    goToListClosure?(carsItemData)
  }

  func fillCollectionView(carsItemData: [CarListItemDataView])
  {
    collectionViewController?.updateCarsData(itemDataView: carsItemData)
  }

  func scrollCollectionTo(index: Int)
  {
    collectionViewController?.scrollToItemAt(index: index)
  }
}

class CarsMapViewDelegate: NSObject, MKMapViewDelegate
{
  var didSelectId: ((_ index: String) -> Void)?

  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
  {
    if let annotation = view.annotation as? CarMapAnnotation
    {
      didSelectId?(annotation.carId)
    }
  }
}
