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

class StudioMapViewController: UIViewController, CLLocationManagerDelegate {
  
  // MARK: - Properties
  private let mapView = NMFNaverMapView(frame: .zero)
  private let myLocationButton = UIButton()
  private let marker = NMFMarker()
  private let magnifyingGlassButton = UIButton().then {
    $0.setImage(Asset.icnSearch.image, for: .normal)
  }
  private let searchPlaceTextField = UITextField().then {
    $0.backgroundColor = .darkGrey2
    $0.layer.borderColor = UIColor.fillinRed.cgColor
    $0.layer.borderWidth = 1
    $0.textColor = .grey2 // 검색했을 때 글씨색 질문
    $0.font = UIFont(name: "NotoSansKR-Regular", size: 14)
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
    mapView.mapView.mapType = .navi
    mapView.mapView.isNightModeEnabled = true
    mapView.showZoomControls = false
    mapView.showScaleBar = false
  }
  
  private func setUpMarker() {
    marker.position = NMGLatLng(lat: 37.45201087366944, lng: 126.65536562781361)
    marker.iconImage = NMFOverlayImage(name: "icnPlaceBig")
    marker.mapView = self.mapView.mapView
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
  
  private func layoutSeachView() {
    view.addSubview(searchPlaceTextField)
    view.addSubview(magnifyingGlassButton)
    searchPlaceTextField.snp.makeConstraints {
      $0.top.equalTo(self.view).inset(111)
      $0.left.equalTo(self.view).inset(18)
      $0.right.equalTo(self.view).inset(18)
      $0.size.height.equalTo(48)
    }
    magnifyingGlassButton.snp.makeConstraints {
      $0.top.equalTo(searchPlaceTextField).inset(11)
      $0.left.equalTo(searchPlaceTextField).inset(295)
      $0.right.equalTo(searchPlaceTextField).inset(18)
      $0.bottom.equalTo(searchPlaceTextField).inset(11)
    }
    magnifyingGlassButton.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
  }
}

// MARK: - @objc
extension StudioMapViewController {
  
  @objc func locationTapped(_ sender: UIButton) {
    if sender.isSelected == true {
      sender.isSelected = false
      mapView.mapView.positionMode = .direction
    } else {
      sender.isSelected = true
      mapView.mapView.positionMode = .direction
    }
  }
  
  @objc func searchTapped(_ sender: UIButton) {
    /// 이부분은 뷰 더 나오면 나중에 구현
  }
}

// MARK: - Extension - UITextField
extension UITextField {
  
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
  
  func setPlaceHolder() { // 폰트 적용 안됨 문제 ㅜㅅㅜ
    let attributes = [
      NSAttributedString.Key.foregroundColor: UIColor.grey2
      // NSAttributedString.Key.font: UIFont(name: "NotoSansKR-Regular", size: 14)!
    ]
    self.attributedPlaceholder = NSAttributedString(string: "추억을 현상할 현상소를 검색해보세요", attributes: attributes)
  }
}
