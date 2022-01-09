//
//  StudioMapViewController.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/09.
//

import UIKit

import NMapsMap
import CoreLocation
import SnapKit
import Then

class StudioMapViewController: UIViewController, CLLocationManagerDelegate {
  
  // MARK: - Properties
  private let mapView = NMFNaverMapView(frame: .zero)
  
  var locationManager = CLLocationManager()
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpMapView()
    layoutMapView()
    setUpLocation()
  }
}

// MARK: - Extensions
extension StudioMapViewController {
  
  private func setUpMapView() {
    view.addSubview(mapView)
  }
  
  private func layoutMapView() {
    mapView.snp.makeConstraints {
      $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
      $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
      $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
      $0.bottom.equalTo(self.view.snp.bottom)
    }
  }
  
  private func setUpLocation() {
    mapView.showLocationButton = true
    mapView.mapView.positionMode = .direction
    
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
  }
}
