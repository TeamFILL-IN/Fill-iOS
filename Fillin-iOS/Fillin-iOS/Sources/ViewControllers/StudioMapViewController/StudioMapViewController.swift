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
  
  // MARK: - Properties (BottomSheet)
  enum BottomSheetViewState {
    case expanded
    case normal
  }
  
  private let contentViewController: UIViewController
  private var bottomSheetViewTopConstraint: NSLayoutConstraint!
  var bottomSheetPanMinTopConstant: CGFloat = 50.0
  var bottomHeight: CGFloat = UIScreen.main.bounds.size.height*(3/7)
  let defaultHeight: CGFloat = UIScreen.main.bounds.size.height*(3/7)
  private lazy var bottomSheetPanStartingTopConstant: CGFloat = bottomSheetPanMinTopConstant
  
  let bottomSheetView: UIView = {
    let view = UIView()
    view.backgroundColor = .darkGrey2
    
    return view
  }()
  
  private let dismissIndicatorView: UIView = {
    let view = UIView()
    view.backgroundColor = .darkGrey1
    view.layer.cornerRadius = 3
    
    return view
  }()
  
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
  var clickCount = 0
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
    getBottomSheetInfo()
    totalStudioWithAPI()
    setLatLngNotification()
    tmpSetupMarker()
    setupBottomSheetUI()
    setupBottomSheetGestureRecognizer()
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
  
  /// 서버 부활되기 전까지 현상소 관련 기능 테스트할 임시 함수 (네이버 그린팩토리에 현상소 표시해줌)
  func tmpSetupMarker() {
    let markertmp = NMFMarker(position: NMGLatLng(lat: 37.35940010181669, lng: 127.10475679570187))
    markertmp.iconImage = NMFOverlayImage(image: Asset.icnStudio.image)
    markertmp.mapView = self.mapView.mapView
    
    let secondMarkertmp = NMFMarker(position: NMGLatLng(lat: 37.36161841308457, lng: 127.10566240106306))
    secondMarkertmp.iconImage = NMFOverlayImage(image: Asset.icnStudio.image)
    secondMarkertmp.mapView = self.mapView.mapView
    
    secondMarkertmp.touchHandler = { [weak self] (overlay: NMFOverlay) -> Bool in
      if self?.selectedMarker == nil { /// 클릭했던 현상소가 없는 경우 (지도뷰 처음 들어올 떄)
        self?.selectedMarker = secondMarkertmp
        self?.selectedMarker?.iconImage = NMFOverlayImage(image: Asset.icnStudioSelected.image)
        self?.showBottomSheet()
      } else {
        if self?.selectedMarker == secondMarkertmp { /// 클릭했던 현상소를 다시 클릭하는 경우
          self?.selectedMarker?.iconImage = NMFOverlayImage(image: Asset.icnStudio.image)
          self?.hideBottomSheetAndGoBack()
        } else { /// 다른 현상소 클릭
          self?.selectedMarker?.iconImage = NMFOverlayImage(image: Asset.icnStudio.image)
          self?.selectedMarker = secondMarkertmp
          self?.selectedMarker?.iconImage = NMFOverlayImage(image: Asset.icnStudioSelected.image)
          self?.showBottomSheet()
        }
      }
      return true
    }
  
    markertmp.touchHandler = { [weak self] (overlay: NMFOverlay) -> Bool in
      if self?.selectedMarker == nil { /// 클릭했던 현상소가 없는 경우 (지도뷰 처음 들어올 떄)
        self?.selectedMarker = markertmp
        self?.selectedMarker?.iconImage = NMFOverlayImage(image: Asset.icnStudioSelected.image)
        self?.showBottomSheet()
      } else {
        if self?.selectedMarker == markertmp { /// 클릭했던 현상소를 다시 클릭하는 경우
          self?.selectedMarker?.iconImage = NMFOverlayImage(image: Asset.icnStudio.image)
          self?.selectedMarker = nil
          self?.hideBottomSheetAndGoBack()
        } else { /// 다른 현상소 클릭
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
    
    serverStudios?.studios.forEach {
      let marker = NMFMarker(position: NMGLatLng(lat: $0.lati, lng: $0.long))
      let markerInfo = Studio(id: $0.id, lati: $0.lati, long: $0.long)
      marker.iconImage = NMFOverlayImage(image: Asset.icnStudio.image)
      
      marker.touchHandler = { [weak self] (overlay: NMFOverlay) -> Bool in
        if self?.selectedMarker == nil { /// 클릭했던 현상소가 없는 경우 (지도뷰 처음 들어올 떄)
          self?.selectedMarker = marker
          self?.selectedMarker?.iconImage = NMFOverlayImage(image: Asset.icnStudioSelected.image)
          self?.showBottomSheet()
          self?.selectedMarkerInfo  = markerInfo
          StudioMapViewController.selectedMarkerID = markerInfo.id
          self?.studioInfoWithAPI(studioID: markerInfo.id)
          // TODO: - 카메라 이동 (통신 필요)
        } else {
          if self?.selectedMarker == marker { /// 클릭했던 현상소를 다시 클릭하는 경우
            self?.selectedMarker?.iconImage = NMFOverlayImage(image: Asset.icnStudio.image)
            self?.selectedMarker = nil
            self?.hideBottomSheetAndGoBack()
          } else { /// 다른 현상소 클릭
            self?.selectedMarker?.iconImage = NMFOverlayImage(image: Asset.icnStudio.image)
            self?.selectedMarker = marker
            self?.selectedMarker?.iconImage = NMFOverlayImage(image: Asset.icnStudioSelected.image)
            self?.showBottomSheet()
            // TODO: - 카메라 이동 (통신 필요)
          }
        }
        return true
      }
      marker.mapView = self.mapView.mapView
    }
  }
  
  func getBottomSheetInfo() {
    StudioMapViewController.name = "필린 현상소"
    StudioMapViewController.address = "솝트시 앱잼구 필린동 아요로 12번길 13"
    StudioMapViewController.time = "open 00:00-24:00"
    StudioMapViewController.tel = "010-1234-5678"
    StudioMapViewController.price = "컬러 5000000000원"
    StudioMapViewController.site = ""
    
//    StudioMapViewController.name = self.serverStudioInfo?.studio.name
//    StudioMapViewController.address = self.serverStudioInfo?.studio.address
//    StudioMapViewController.time = self.serverStudioInfo?.studio.time
//    StudioMapViewController.tel = self.serverStudioInfo?.studio.tel
//    StudioMapViewController.price = self.serverStudioInfo?.studio.price
//    StudioMapViewController.site = self.serverStudioInfo?.studio.site
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
  
  // MARK: - @objc
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
}

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

// MARK: - Extension - BottomSheet
extension StudioMapViewController {

  private func setupBottomSheetUI() {
    addChild(contentViewController)
    bottomSheetView.addSubview(contentViewController.view)
    contentViewController.didMove(toParent: self)
    view.addSubviews([bottomSheetView, dismissIndicatorView])

    let viewPan = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))
    
    viewPan.delaysTouchesBegan = false
    viewPan.delaysTouchesEnded = false
    view.addGestureRecognizer(viewPan)
    
    setupBottomSheetLayout()
  }
  
  private func setupBottomSheetGestureRecognizer() {
    let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(panGesture))
    swipeGesture.direction = .down
    view.addGestureRecognizer(swipeGesture)
  }
  
  private func setupBottomSheetLayout() {
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
    getBottomSheetInfo()
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
