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
  private let myLocationButton = UIButton()
  
  var locationManager = CLLocationManager()
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpMapView()
    layoutMapView()
    layoutMyLocationButton()
  }
}

// MARK: - Extensions
extension StudioMapViewController {
  
  private func setUpMapView() {
    view.addSubview(mapView)
    mapView.mapView.mapType = .navi
    mapView.mapView.isNightModeEnabled = true
    mapView.showZoomControls = false
    mapView.showScaleBar = false
  }
  
  private func layoutMapView() {
    mapView.snp.makeConstraints {
      $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
      $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
      $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
      $0.bottom.equalTo(self.view.snp.bottom)
    }
  }
  
  private func layoutMyLocationButton() {
    view.addSubview(myLocationButton)
    myLocationButton.setImage(UIImage(named: "icnMyLocation"), for: .normal)
    myLocationButton.snp.makeConstraints {
      $0.top.equalTo(self.view).inset(708)
      $0.left.equalTo(self.view).inset(299)
      $0.right.equalTo(self.view).inset(20)
      $0.bottom.equalTo(self.view).inset(48)
    }
    myLocationButton.addTarget(self, action: #selector(locationTapped), for: .touchUpInside)
  }
  
  // 버튼 기능 구현
  @objc func locationTapped(_ sender: UIButton) {
    if sender.isSelected == true {
      sender.isSelected = false
      mapView.mapView.positionMode = .direction
    } else {
      sender.isSelected = true
      mapView.mapView.positionMode = .disabled
    }
  }
}
