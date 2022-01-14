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
import MapKit

class StudioMapViewController: UIViewController {
  
  // MARK: - Properties
  private let mapView = NMFNaverMapView(frame: .zero)
  private let myLocationButton = UIButton()
  private let marker = NMFMarker()
  private let bottomSheet = StudioMapBottomSheetViewController()
  private let magnifyingGlassButton = UIButton().then {
    $0.setImage(Asset.icnSearch.image, for: .normal)
  }
  private let searchPlaceTextField = UITextField().then {
    $0.backgroundColor = .darkGrey2
    $0.layer.borderColor = UIColor.fillinRed.cgColor
    $0.layer.borderWidth = 1
    $0.textColor = .white
    $0.font = .body2
    $0.setPlaceHolder()
    $0.addLeftPadding()
  }
  
  var locationManager = CLLocationManager()
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpMapView()
    layoutMapView()
    layoutMyLocationButton()
    layoutSeachView()
    setUpMarker()
  }
  
  // MARK: - Custom Func
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
}

// MARK: - Extensions
extension StudioMapViewController {
  
  private func setUpMapView() {
    view.addSubview(mapView)
    mapView.mapView.positionMode = .direction
    mapView.mapView.mapType = .navi
    mapView.mapView.isNightModeEnabled = true
    mapView.showZoomControls = false
    mapView.showScaleBar = false
    
    locationManager.delegate = self
    self.locationManager.requestWhenInUseAuthorization()
  }
  
  private func setUpMarker() {
    marker.position = NMGLatLng(lat: 37.56383740177333, lng: 126.92093672692367) /// 홍대
    marker.position = NMGLatLng(lat: 37.45201087366944, lng: 126.65536562781361) /// 인천
    marker.iconImage = NMFOverlayImage(image: Asset.icnPlaceBig.image)
    marker.mapView = self.mapView.mapView
  }
  
  private func layoutMapView() {
    mapView.snp.makeConstraints {
      $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
      $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
      $0.bottom.equalTo(self.view.snp.bottom)
      $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
    }
  }
  
  private func layoutMyLocationButton() {
    view.addSubview(myLocationButton)
    myLocationButton.setImage(Asset.icnMyLocation.image, for: .normal)
    myLocationButton.snp.makeConstraints {
      $0.top.equalTo(self.view).inset(708)
      $0.leading.equalTo(self.view).inset(299)
    }
    myLocationButton.addTarget(self, action: #selector(touchLocationButton), for: .touchUpInside)
  }
  
  private func layoutSeachView() {
    view.addSubview(searchPlaceTextField)
    view.addSubview(magnifyingGlassButton)
    searchPlaceTextField.snp.makeConstraints {
      $0.top.equalTo(self.view).inset(111)
      $0.leading.equalTo(self.view).inset(18)
      $0.trailing.equalTo(self.view).inset(18)
      $0.size.height.equalTo(48)
    }
    magnifyingGlassButton.snp.makeConstraints {
      $0.top.equalTo(searchPlaceTextField).inset(11)
      $0.leading.equalTo(searchPlaceTextField).inset(295)
      $0.bottom.equalTo(searchPlaceTextField).inset(11)
      $0.trailing.equalTo(searchPlaceTextField).inset(18)
    }
    magnifyingGlassButton.addTarget(self, action: #selector(touchSearchButton), for: .touchUpInside)
  }

}

// MARK: - @objc
extension StudioMapViewController {
  
  @objc func touchLocationButton(_ sender: UIButton) {
    sender.isSelected = !sender.isSelected
    mapView.mapView.positionMode = .direction
  }
  
  @objc func touchSearchButton(_ sender: UIButton) {
  }
}

// MARK: - Extension - UITextField
extension UITextField {
  
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
  
  func setPlaceHolder() {
    let attributes = [
      NSAttributedString.Key.foregroundColor: UIColor.grey2,
      NSAttributedString.Key.font: UIFont(name: "NotoSansKR-Regular", size: 14)!
    ]
    self.attributedPlaceholder = NSAttributedString(string: "추억을 현상할 현상소를 검색해보세요", attributes: attributes)
  }
}

// MARK: - Extension - CLLocationManagerDelegate
extension StudioMapViewController: CLLocationManagerDelegate {
  
  func getLocationUsagePermission() {
    self.locationManager.requestWhenInUseAuthorization()
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
    case .authorizedAlways, .authorizedWhenInUse:
      print("GPS 권한 설정됨")
      self.locationManager.startUpdatingLocation()
    case .restricted, .notDetermined:
      print("GPS 권한 설정되지 않음")
      getLocationUsagePermission()
    case .denied:
      print("GPS 권한 요청 거부됨")
      getLocationUsagePermission()
    default:
      print("GPS: Default")
    }
  }
}
