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
  var serverStudios: StudioResponse?
  let mapView = NMFNaverMapView(frame: .zero)
  let myLocationButton = UIButton()
  let dataSource = NMFInfoWindowDefaultTextSource.data()
  let magnifyingGlassButton = UIButton().then {
    $0.setImage(Asset.icnSearch.image, for: .normal)
  }
  let searchPlaceTextField = UITextField().then {
    $0.backgroundColor = .darkGrey2
    $0.layer.borderColor = UIColor.fillinRed.cgColor
    $0.layer.borderWidth = 1
    $0.textColor = .white
    $0.font = .body2
    $0.setPlaceHolder()
    $0.addLeftPadding()
  }
  var markerState = 0
  var locationManager = CLLocationManager()
  let navigationBar = FilinNavigationBar()
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpMapView()
    setUpNavigationBar()
    layoutMapView()
    layoutMyLocationButton()
    setUpMarkerInfo()
    layoutSearchView()
    layoutNavigaionBar()
    showNaverMarker()
    totalStudioWithAPI()
  }
}

// MARK: - Extensions
extension StudioMapViewController {
  
  private func setUpMapView() {
    view.addSubview(mapView)
    let locationOverlay = mapView.mapView.locationOverlay
    mapView.mapView.positionMode = .direction
    mapView.mapView.mapType = .navi
    mapView.mapView.isNightModeEnabled = true
    mapView.showZoomControls = false
    mapView.showScaleBar = false
    locationOverlay.hidden = true
    locationOverlay.icon = NMFOverlayImage(image: Asset.icnPlaceBig.image)
    
    locationManager.delegate = self
    self.locationManager.requestWhenInUseAuthorization()
  }
  
  func showNaverMarker() {
    let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: 37.35940010181669, lng: 127.10475679570187))
    mapView.mapView.moveCamera(cameraUpdate)
  }

  private func setUpMarkerInfo() {
    self.mapView.mapView.touchDelegate = self
    
    let marker = NMFMarker(position: NMGLatLng(lat: 37.35940010181669, lng: 127.10475679570187))
    marker.iconImage = NMFOverlayImage(image: Asset.icnPlaceBig2.image)
    
    marker.touchHandler = { [weak self] (overlay: NMFOverlay) -> Bool in
      switch self?.markerState {
      case 0:
        self?.markerState = 1
        marker.iconImage = NMFOverlayImage(image: Asset.icnPlaceBig.image)
      case 1:
        self?.markerState = 0
        marker.iconImage = NMFOverlayImage(image: Asset.icnPlaceBig2.image)
      default:
        print("no")
      }
      let nextVC = StudioMapBottomSheetViewController(contentViewController: StudioMapContentViewController())
      nextVC.modalPresentationStyle = .overCurrentContext
      nextVC.modalTransitionStyle = .crossDissolve
      self?.present(nextVC, animated: false, completion: nil)
      return true
    }
    marker.mapView = self.mapView.mapView
  }
  
  private func setUpNavigationBar() {
    self.navigationController?.navigationBar.isHidden = true
    navigationBar.popViewController = { self.navigationController?.popViewController(animated: true) }
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
  
  private func layoutSearchView() {
    view.addSubview(searchPlaceTextField)
    view.addSubview(magnifyingGlassButton)
    magnifyingGlassButton.snp.makeConstraints {
      $0.top.equalTo(searchPlaceTextField).inset(11)
      $0.leading.equalTo(searchPlaceTextField).inset(295)
      $0.bottom.equalTo(searchPlaceTextField).inset(11)
      $0.trailing.equalTo(searchPlaceTextField).inset(18)
    }
    searchPlaceTextField.snp.makeConstraints {
      $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(68)
      $0.leading.equalTo(self.view).inset(18)
      $0.trailing.equalTo(self.view).inset(18)
      $0.size.height.equalTo(48)
    }
    searchPlaceTextField.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .touchDown)
  }
  
  func layoutNavigaionBar() {
    view.add(navigationBar) {
      self.navigationBar.popViewController = {
        self.navigationController?.popViewController(animated: true)
      }
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        $0.leading.trailing.equalToSuperview()
        $0.height.equalTo(50)
      }
    }
  }
  
  @objc func textFieldDidBeginEditing(_ textField: UITextField) {
    let newVC = StudioMapSearchViewController()
    newVC.modalTransitionStyle = .crossDissolve
    newVC.modalPresentationStyle = .fullScreen
    self.present(newVC, animated: true, completion: nil)
  }
}

// MARK: - @objc
extension StudioMapViewController {
  
  @objc func touchLocationButton(_ sender: UIButton) {
    sender.isSelected = !sender.isSelected
    mapView.mapView.positionMode = .direction
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

// MARK: - Extension
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

extension StudioMapViewController: NMFMapViewTouchDelegate {
}

extension StudioMapViewController {
  func totalStudioWithAPI() {
    StudioMapAPI.shared.totalStudio { response in
      switch response {
      case .success(let data):
        print(data, "sdfsdfsdf")
        if let studios = data as? StudioResponse {
          self.serverStudios = studios
        }
      case .requestErr(let message):
        print("totalStudioWithAPI - requestErr: \(message)")
      case .pathErr:
        print("totalStudioWithAPI - pathErr")
      case .serverErr:
        print("totalStudioWithAPI - serverErr")
      case .networkFail:
        print("totalStudioWithAPI - networkFail")
      }
    }
  }
}
