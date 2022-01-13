//
//  MapTableViewCell.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/12.
//

import UIKit
import NMapsMap

class MapTableViewCell: UITableViewCell {

    var locationManager = CLLocationManager()
    
    @IBOutlet weak var naverMapView: NMFMapView!
    
    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
        getLocationUsagePermission()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    // MARK: - Functions
    static func nib() -> UINib {
        return UINib(nibName: Const.Xib.mapTableViewCell, bundle: Bundle(for: MapTableViewCell.self))
    }
    
    private func setUI() {
        naverMapView.mapType = .navi
        naverMapView.isNightModeEnabled = true
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        let locationOverlay = naverMapView.locationOverlay
        naverMapView.positionMode = .direction
        
        if CLLocationManager.locationServicesEnabled() {
            print("위치 서비스 On 상태")
            locationManager.startUpdatingLocation()

            // 현 위치로 카메라 이동
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0))
            cameraUpdate.animation = .easeIn
            naverMapView.moveCamera(cameraUpdate)
            
            locationOverlay.location = NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0,
                                                 lng: locationManager.location?.coordinate.longitude ?? 0)
            
        } else {
            print("위치 서비스 Off 상태")
        }
    }
    
    private func getLocationUsagePermission() {
        locationManager.requestWhenInUseAuthorization()
    }
}

// MARK: - Extension - CLLocationManagerDelegate
extension MapTableViewCell: CLLocationManagerDelegate {
    
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
