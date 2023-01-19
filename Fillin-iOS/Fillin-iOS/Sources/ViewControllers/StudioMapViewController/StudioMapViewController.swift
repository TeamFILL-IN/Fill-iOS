//
//  StudioMapViewController.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/09.
//

import UIKit

import SnapKit
import Then
import NMapsMap
import CoreLocation
import MapKit

class StudioMapViewController: UIViewController {
      
  // MARK: - Properties (BottomSheet)
  enum BottomSheetViewState {
    case expanded
    case normal
  }
  
  private let contentViewController: UIViewController
  private var bottomSheetViewTopConstraint: NSLayoutConstraint!
  private let bottomSheetPanMinTopConstant: CGFloat = 50.0
  private var bottomHeight: CGFloat = UIScreen.main.bounds.size.height*(3/7)
  private let defaultHeight: CGFloat = UIScreen.main.bounds.size.height*(3/7)
  private lazy var bottomSheetPanStartingTopConstant: CGFloat = bottomSheetPanMinTopConstant
  
  let bottomSheetView = UIView().then {
    $0.backgroundColor = .darkGrey2
  }
  
  private let dismissIndicatorView = UIView().then {
    $0.backgroundColor = .darkGrey1
    $0.layer.cornerRadius = 3
  }
  
  // MARK: - Properties
  var serverStudioInfo = StudioInfoResponse(studio: StudioInfo(id: 0, name: "", address: "", price: "", time: "", tel: "", lati: 0, long: 0, etc: "", isDeleted: false, site: ""))
  var serverStudios = StudioResponse(studios: [])
  var selectedMarkerInfo = Studio(id: 0, lati: 0, long: 0)
  var selectedMarker: NMFMarker?
  var locationManager = CLLocationManager()
  
  // MARK: - UI Properties
  private let navigationBar = FilinNavigationBar()
  private let mapView = NMFNaverMapView(frame: .zero)
  private let magnifyingGlassButton = UIButton().then {
    $0.setImage(Asset.icnSearch.image, for: .normal)
  }
  private lazy var searchPlaceTextField = UITextField().then {
    $0.backgroundColor = .darkGrey2
    $0.layer.borderColor = UIColor.fillinRed.cgColor
    $0.layer.borderWidth = 1
    $0.textColor = .white
    $0.font = .body2
    $0.setPlaceHolder()
    $0.addLeftPadding()
    $0.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .touchDown)
  }
  private lazy var myLocationButton = UIButton().then {
    $0.setImage(Asset.icnMyLocation.image, for: .normal)
    $0.addTarget(self, action: #selector(touchLocationButton), for: .touchUpInside)
  }
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setAttribute()
    setLayout()
    totalStudioWithAPI()
  }
  
  // MARK: - init
  init(contentViewController: UIViewController) {
    self.contentViewController = contentViewController
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Extensions

extension StudioMapViewController {
  private func setAttribute() {
    tmpSetupMarker()
    setUpMapView()
    setUpBottomSheetUI()
    setUpMarkerInfo()
    setUpNavigationBar()
    setUpBottomSheetGestureRecognizer()
    setLatLngNotification()
  }
  
  private func tmpSetupMarker() {
    let markertmp = NMFMarker(position: NMGLatLng(lat: 37.556393, lng: 126.9716552))
    markertmp.iconImage = NMFOverlayImage(image: Asset.icnStudio.image)
    markertmp.mapView = self.mapView.mapView
    markertmp.touchHandler = { [weak self] (_: NMFOverlay) -> Bool in
      if self?.selectedMarker == nil {
        self?.selectedMarker = markertmp
        self?.selectedMarker?.iconImage = NMFOverlayImage(image: Asset.icnStudioSelected.image)
        self?.showBottomSheet()
      } else {
        if self?.selectedMarker == markertmp {
          self?.selectedMarker?.iconImage = NMFOverlayImage(image: Asset.icnStudio.image)
          self?.selectedMarker = nil
          self?.hideBottomSheetAndGoBack()
        } else {
          self?.selectedMarker?.iconImage = NMFOverlayImage(image: Asset.icnStudio.image)
          self?.selectedMarker = markertmp
          self?.selectedMarker?.iconImage = NMFOverlayImage(image: Asset.icnStudioSelected.image)
          self?.showBottomSheet()
        }
      }
      return true
    }
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
  
  private func setUpMarkerInfo() {
    self.mapView.mapView.touchDelegate = self
    
    serverStudios.studios.forEach {
      let marker = NMFMarker(position: NMGLatLng(lat: $0.lati, lng: $0.long))
      let markerInfo = Studio(id: $0.id, lati: $0.lati, long: $0.long)
      marker.iconImage = NMFOverlayImage(image: Asset.icnStudio.image)
      
      selectedMarkerInfo  = markerInfo
      studioInfoWithAPI(studioID: markerInfo.id)
      
      marker.touchHandler = { [weak self] (_: NMFOverlay) -> Bool in
        if self?.selectedMarker == nil {
          self?.selectedMarker = marker
          self?.selectedMarker?.iconImage = NMFOverlayImage(image: Asset.icnStudioSelected.image)
          self?.showBottomSheet()
        } else {
          if self?.selectedMarker == marker {
            self?.selectedMarker = nil
            self?.selectedMarker?.iconImage = NMFOverlayImage(image: Asset.icnStudio.image)
            self?.hideBottomSheetAndGoBack()
          } else {
            self?.selectedMarker?.iconImage = NMFOverlayImage(image: Asset.icnStudio.image)
            self?.selectedMarker = marker
            self?.selectedMarker?.iconImage = NMFOverlayImage(image: Asset.icnStudioSelected.image)
            self?.showBottomSheet()
          }
        }
        return true
      }
      marker.mapView = self.mapView.mapView
    }
  }
  
  private func setUpNavigationBar() {
    self.navigationController?.navigationBar.isHidden = true
    navigationBar.popViewController = { self.navigationController?.popViewController(animated: true) }
  }
 
  private func setLatLngNotification() {
    NotificationCenter.default.addObserver(self, selector: #selector(getLatLng(_:)), name: Notification.Name("GetLatLng"), object: nil)
  }
}

extension StudioMapViewController {
  private func setLayout() {
    layoutMapView()
    layoutMyLocationButton()
    layoutSearchView()
    layoutNavigaionBar()
    view.bringSubviewToFront(bottomSheetView)
    view.bringSubviewToFront(dismissIndicatorView)
  }
  
  private func layoutMapView() {
    mapView.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
      $0.bottom.equalToSuperview()
    }
  }
  
  private func layoutMyLocationButton() {
    view.addSubview(myLocationButton)
    myLocationButton.snp.makeConstraints {
      $0.trailing.equalToSuperview().offset(-20)
      $0.bottom.equalToSuperview().offset(-48)
    }
  }
  
  private func layoutSearchView() {
    view.addSubviews([searchPlaceTextField, magnifyingGlassButton])
    searchPlaceTextField.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).inset(68)
      $0.leading.trailing.equalToSuperview().inset(18)
      $0.height.equalTo(48)
    }
    magnifyingGlassButton.snp.makeConstraints {
      $0.centerY.equalTo(searchPlaceTextField)
      $0.trailing.equalTo(searchPlaceTextField).inset(18)
    }
  }
  
  func layoutNavigaionBar() {
    view.add(navigationBar)
    navigationBar.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(50)
    }
  }
  
  // MARK: - @objc
  @objc func getLatLng(_ notification: Notification) {
    let selectedStudioId = notification.object as? Int ?? 0
    studioInfoWithAPI(studioID: selectedStudioId)
  }
  
  @objc func textFieldDidBeginEditing(_ textField: UITextField) {
    let newVC = StudioMapSearchViewController()
    newVC.modalTransitionStyle = .crossDissolve
    newVC.modalPresentationStyle = .fullScreen
    self.present(newVC, animated: true, completion: nil)
  }
  
  @objc func touchLocationButton(_ sender: UIButton) {
    sender.isSelected.toggle()
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
    self.attributedPlaceholder = NSAttributedString(string: "현상소 이름 또는 주소로 검색해보세요", attributes: attributes)
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

// MARK: - Extension - NMFMapBiewTouchDelegate
extension StudioMapViewController: NMFMapViewTouchDelegate {
}

// MARK: - Extension - Network
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
  func studioInfoWithAPI(studioID: Int) {
    StudioMapAPI.shared.infoStudio(studioID: studioID) { response in
      switch response {
      case .success(let data):
        if let studioinfo = data as? StudioInfoResponse {
          self.serverStudioInfo = studioinfo
          let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: studioinfo.studio.lati ?? 0, lng: studioinfo.studio.long ?? 0))
          self.mapView.mapView.moveCamera(cameraUpdate)
          NotificationCenter.default.post(name: Notification.Name.studioPhotoswithAPI, object: nil)
          self.showBottomSheet()
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

// MARK: - BottomSheet
extension StudioMapViewController {
  private func setUpBottomSheetUI() {
    addChild(contentViewController)
    bottomSheetView.addSubview(contentViewController.view)
    contentViewController.didMove(toParent: self)
    view.addSubviews([bottomSheetView, dismissIndicatorView])
    
    let viewPan = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))
    
    viewPan.delaysTouchesBegan = false
    viewPan.delaysTouchesEnded = false
    view.addGestureRecognizer(viewPan)
    
    setUpBottomSheetLayout()
  }
  
  private func setUpBottomSheetGestureRecognizer() {
    let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(panGesture))
    swipeGesture.direction = .down
    view.addGestureRecognizer(swipeGesture)
  }
  
  private func setUpBottomSheetLayout() {
    contentViewController.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      contentViewController.view.topAnchor.constraint(equalTo: bottomSheetView.topAnchor),
      contentViewController.view.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor),
      contentViewController.view.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor),
      contentViewController.view.bottomAnchor.constraint(equalTo: bottomSheetView.bottomAnchor)
    ])
    
    bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
    let topConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height
    bottomSheetViewTopConstraint = bottomSheetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstant)
    NSLayoutConstraint.activate([
      bottomSheetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      bottomSheetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      bottomSheetViewTopConstraint
    ])
    
    dismissIndicatorView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      dismissIndicatorView.widthAnchor.constraint(equalToConstant: 40),
      dismissIndicatorView.heightAnchor.constraint(equalToConstant: 3),
      dismissIndicatorView.topAnchor.constraint(equalTo: bottomSheetView.topAnchor, constant: 12),
      dismissIndicatorView.centerXAnchor.constraint(equalTo: bottomSheetView.centerXAnchor)
    ])
  }
  
  private func showBottomSheet(atState: BottomSheetViewState = .normal) {
    if atState == .normal {
      changeScrollDisabled()
      let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
      let bottomPadding: CGFloat = view.safeAreaInsets.bottom
      bottomSheetViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - defaultHeight
    } else {
      changeScrollEnabled()
      bottomSheetViewTopConstraint.constant = bottomSheetPanMinTopConstant
    }
    UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
      self.view.layoutIfNeeded()
    }, completion: nil)
  }
  
  func hideBottomSheetAndGoBack() {
    let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
    let bottomPadding = view.safeAreaInsets.bottom
    self.selectedMarker?.iconImage = NMFOverlayImage(image: Asset.icnStudio.image)
    self.selectedMarker = nil
    bottomSheetViewTopConstraint.constant = safeAreaHeight + bottomPadding
    UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
      self.view.layoutIfNeeded()
    })
  }
  
  func nearest(to number: CGFloat, inValues values: [CGFloat]) -> CGFloat {
    guard let nearestVal = values.min(by: { abs(number - $0) < abs(number - $1) })
    else { return number }
    return nearestVal
  }
  
  func changeScrollEnabled() {
    let contentVC = children.first as? StudioMapContentViewController
    contentVC?.studioScrollview.isScrollEnabled = true
  }
  
  func changeScrollDisabled() {
    let contentVC = children.first as? StudioMapContentViewController
    contentVC?.studioScrollview.isScrollEnabled = false
  }
  
  // MARK: - @objc
  @objc func panGesture(_ recognizer: UISwipeGestureRecognizer) {
    if recognizer.state == .ended {
      switch recognizer.direction {
      case .down:
        hideBottomSheetAndGoBack()
      default:
        break
      }
    }
  }
  
  @objc private func viewPanned(_ panGestureRecognizer: UIPanGestureRecognizer) {
    let translation = panGestureRecognizer.translation(in: self.view)
    let velocity = panGestureRecognizer.velocity(in: view)
    
    switch panGestureRecognizer.state {
    case .began:
      bottomSheetPanStartingTopConstant = bottomSheetViewTopConstraint.constant
    case .changed:
      if bottomSheetPanStartingTopConstant + translation.y > bottomSheetPanMinTopConstant {
        bottomSheetViewTopConstraint.constant = bottomSheetPanStartingTopConstant + translation.y
      }
    case .ended:
      if velocity.y > 1500 {
        hideBottomSheetAndGoBack()
        return
      }
      let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
      let bottomPadding = view.safeAreaInsets.bottom
      let defaultPadding = safeAreaHeight + bottomPadding - defaultHeight
      let nearestValue = nearest(to: bottomSheetViewTopConstraint.constant, inValues: [bottomSheetPanMinTopConstant + 200, defaultPadding, safeAreaHeight + bottomPadding])
      if nearestValue == bottomSheetPanMinTopConstant + 200 {
        showBottomSheet(atState: .expanded)
      } else if nearestValue == defaultPadding {
        showBottomSheet(atState: .normal)
      } else {
        hideBottomSheetAndGoBack()
      }
    default:
      break
    }
  }
}
