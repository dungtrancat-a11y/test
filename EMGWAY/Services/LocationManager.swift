//
//  LocationManager.swift
//  EMGWAY
//
//  Created by Mr. Dũng on 19/8/25.
//

//import UIKit
//import CoreLocation
//
//class LocationManager: NSObject, CLLocationManagerDelegate {
//    static let shared = LocationManager()
//    
//    private let locationManager = CLLocationManager()
//    private var timer: Timer?
//    
//    override init() {
//        super.init()
//        locationManager.delegate = self
//        locationManager.allowsBackgroundLocationUpdates = true
//        locationManager.pausesLocationUpdatesAutomatically = false
//    }
//
//    func startMonitoring() {
//        // Yêu cầu quyền truy cập vị trí
//        locationManager.requestAlwaysAuthorization()
//        
//        // Bắt đầu theo dõi thay đổi vị trí lớn
//        locationManager.startMonitoringSignificantLocationChanges()
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//        print("📍 Vị trí mới: \(location.coordinate.latitude), \(location.coordinate.longitude)")
//        
//        // TODO: Gửi vị trí lên server hoặc xử lý theo nhu cầu
////        locationManager.startUpdatingLocation()
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.distanceFilter = 50
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.allowsBackgroundLocationUpdates = true
//        locationManager.pausesLocationUpdatesAutomatically = false
//        
//        timer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { _ in
//            self.locationManager.requestLocation()
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("❌ Lỗi lấy vị trí: \(error.localizedDescription)")
//    }
//}


import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    
    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 50 // cập nhật mỗi khi di chuyển 50 mét
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
    }

    func startMonitoring() {
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation() // dùng API này để cập nhật liên tục
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        print("📍 Vị trí mới: \(location.coordinate.latitude), \(location.coordinate.longitude)")
        
        // Gửi lên server hoặc xử lý tùy ý
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("❌ Lỗi lấy vị trí: \(error.localizedDescription)")
    }
}
