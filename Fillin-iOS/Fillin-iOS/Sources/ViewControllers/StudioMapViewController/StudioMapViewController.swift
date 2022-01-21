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
  static var name: String?
  static var address: String?
  static var time: String?
  static var tel: String?
  static var price: String?
  static var site: String?
  static var selectedMarkerID: Int?
  static var lati: Double?
  static var long: Double?
  
  var serverStudioInfo: StudioInfoResponse?
  var serverStudios: StudioResponse?
  var selectedMarker: NMFMarker?
  var selectedMarkerInfo: Studio?
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
    layoutSearchView()
    layoutNavigaionBar()
    showNaverMarker()
    totalStudioWithAPI()
    setNotification()
    setLatLngNotification()
  }
}

// MARK: - Extensions
extension StudioMapViewController {
  
  func setNotification() {
    NotificationCenter.default.addObserver(self, selector: #selector(changeMarkerObserver(_:)), name: NSNotification.Name.changeMarker, object: nil)
  }
  
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
    
    serverStudios?.studios.forEach {
      let marker = NMFMarker(position: NMGLatLng(lat: $0.lati, lng: $0.long))
      let markerInfo = Studio(id: $0.id, lati: $0.lati, long: $0.long)
      marker.iconImage = NMFOverlayImage(image: Asset.icnPlaceBig.image)
      
      marker.touchHandler = { [weak self] (overlay: NMFOverlay) -> Bool in
        // NotificationCenter.default.post(name: Notification.Name("StudioPhotoswithAPI"), object: nil)
        self?.markerState = 1
        self?.selectedMarker = marker
        self?.selectedMarkerInfo  = markerInfo
        marker.iconImage = NMFOverlayImage(image: Asset.icnPlaceBig.image)
        self?.setNotification()
        StudioMapViewController.selectedMarkerID = markerInfo.id
        self?.studioInfoWithAPI(studioID: markerInfo.id)
        return true
      }
      marker.mapView = self.mapView.mapView
    }
  }
  
  func presentBottomSheetAfterInfo() {
    StudioMapViewController.name = self.serverStudioInfo?.studio.name
    StudioMapViewController.address = self.serverStudioInfo?.studio.address
    StudioMapViewController.time = self.serverStudioInfo?.studio.time
    StudioMapViewController.tel = self.serverStudioInfo?.studio.tel
    StudioMapViewController.price = self.serverStudioInfo?.studio.price
    StudioMapViewController.site = self.serverStudioInfo?.studio.site
    
    let nextVC = StudioMapBottomSheetViewController(contentViewController: StudioMapContentViewController())
    nextVC.modalPresentationStyle = .overCurrentContext
    nextVC.modalTransitionStyle = .crossDissolve
    self.present(nextVC, animated: false, completion: nil)
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
      $0.trailing.equalToSuperview().offset(-20)
      $0.bottom.equalToSuperview().offset(-48)
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
  
  func setLatLngNotification() {
    NotificationCenter.default.addObserver(self, selector: #selector(getLatLng(_:)), name: Notification.Name("GetLatLng"), object: nil)
  }
  
  @objc func getLatLng(_ notification: Notification) {
    let selectedStudioId = notification.object as? Int ?? 0
    studioInfoWithAPI(studioID: selectedStudioId)

    let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: StudioMapViewController.lati ?? 0, lng: StudioMapViewController.long ?? 0))
    mapView.mapView.moveCamera(cameraUpdate)
  }
  
  @objc func textFieldDidBeginEditing(_ textField: UITextField) {
    let newVC = StudioMapSearchViewController()
    newVC.modalTransitionStyle = .crossDissolve
    newVC.modalPresentationStyle = .fullScreen
    self.present(newVC, animated: true, completion: nil)
  }
  
  @objc func changeMarkerObserver(_ notification: Notification) {
    selectedMarker?.iconImage = NMFOverlayImage(image: Asset.icnPlaceBig.image)
    selectedMarker = nil
    markerState = 0
  }

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
        if let studios = data as? StudioResponse {
          self.serverStudios = studios
          self.setUpMarkerInfo()
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

// MARK: - Network
extension StudioMapViewController {
  func studioInfoWithAPI(studioID: Int) {
    StudioMapAPI.shared.infoStudio(studioID: studioID) { response in
      switch response {
      case .success(let data):
        if let studioinfo = data as? StudioInfoResponse {
          self.serverStudioInfo = studioinfo
          StudioMapViewController.lati = studioinfo.studio.lati
          StudioMapViewController.long = studioinfo.studio.long
    
          let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: StudioMapViewController.lati ?? 0, lng: StudioMapViewController.long ?? 0))
          self.mapView.mapView.moveCamera(cameraUpdate)
          NotificationCenter.default.post(name: Notification.Name("StudioPhotoswithAPI"), object: nil)
          self.presentBottomSheetAfterInfo()
        }
      case .requestErr(let message):
        print("studioInfoWithAPI - requestErr: \(message)")
      case .pathErr:
        print("studioInfoWithAPI - pathErr")
      case .serverErr:
        print("studioInfoWithAPI - serverErr")
      case .networkFail:
        print("studioInfoWithAPI - networkFail")
      }
    }
  }
}
