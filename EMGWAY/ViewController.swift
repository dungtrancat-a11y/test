//
//  ViewController.swift
//  EMGWAY
//
//  Created by Mr. Dũng on 11/7/25.
//

import UIKit
import VietMap

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MGLMapView!
    var coordinates: [CLLocationCoordinate2D] = []
    
    private let locationManager = CLLocationManager()
    private let timeStart: TimeInterval = 10 // ví dụ: 10 giây
    private var timer: Timer?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.delegate = self
        if #available(iOS 10.0, *) {
            
//            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound]) { _,_ in
////                DispatchQueue.main.async {
//                DispatchQueue.main.asyncAfter(deadline: .now() + self.timeStart) {
//                    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
//                    self.locationManager.distanceFilter = kCLDistanceFilterNone
//                    self.locationManager.requestWhenInUseAuthorization()
//                    self.locationManager.startUpdatingLocation()
//                }
//            }
            
            // OK
//            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
//            self.locationManager.distanceFilter = kCLDistanceFilterNone
//            self.locationManager.requestWhenInUseAuthorization()
//            
//            timer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { _ in
//                self.locationManager.requestLocation()
//            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("Vị trí hiện tại: \(location.coordinate.latitude), \(location.coordinate.longitude)")
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Lỗi lấy vị trí: \(error.localizedDescription)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        startMapView()
//        drawPolygon()
    }


    func startMapView() {
        mapView = MGLMapView(frame: view.bounds, styleURL: URL(string: "https://maps.vietmap.vn/api/maps/light/styles.json?apikey=42df7c6273fc935320d55318f08c3372ad09be1c83757b4e"))
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        mapView.userTrackingMode = .follow

        let singleTap = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress(tap:)))
        mapView.gestureRecognizers?.filter({ $0 is UILongPressGestureRecognizer }).forEach(singleTap.require(toFail:))
        mapView.addGestureRecognizer(singleTap)
        view.addSubview(mapView)
    }

    func drawPolyline() {
        let polyline = MGLPolyline(coordinates: coordinates, count: UInt(coordinates.count))
        mapView.addAnnotation(polyline)
    }

    func drawPolygon() {
        let coordinates = [
            CLLocationCoordinate2D(latitude: 10.745863, longitude: 106.655122),
            CLLocationCoordinate2D(latitude: 10.753557, longitude: 106.649735),
            CLLocationCoordinate2D(latitude: 10.765662, longitude: 106.681285),
            CLLocationCoordinate2D(latitude: 10.750961, longitude: 106.683948)
        ]
        let polygon = MGLPolygon(coordinates: coordinates, count: UInt(coordinates.count))
        mapView.addAnnotation(polygon)
    }

    // MARK: Gesture Recognizer Handlers
    @objc func didLongPress(tap: UILongPressGestureRecognizer) {
        guard let mapView = mapView else { return }
        if (coordinates.isEmpty) {
            coordinates.append((mapView.userLocation?.location?.coordinate)!)
        }
        let point = mapView.convert(tap.location(in: mapView), toCoordinateFrom: mapView)
        let annotation = MGLPointAnnotation()
        annotation.coordinate = point
        annotation.title = "Point Here"
        coordinates.append(point)
        mapView.addAnnotation(annotation)
        drawPolyline()
    }
}

extension ViewController: MGLMapViewDelegate {
    func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
        let image = UIImage(systemName: "car")!
        image.withTintColor(UIColor.red)
        let annotationImage = MGLAnnotationImage(image: image, reuseIdentifier: "customAnnotation")

        return annotationImage
    }

    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }

    func mapView(_ mapView: MGLMapView, leftCalloutAccessoryViewFor annotation: MGLAnnotation) -> UIView? {
        let imageView = UIImageView(image: UIImage(named: "leftAccessoryImage"))
        return imageView
    }

    func mapView(_ mapView: MGLMapView, rightCalloutAccessoryViewFor annotation: MGLAnnotation) -> UIView? {
        let button = UIButton(type: .detailDisclosure)
        return button
    }

    func mapView(_ mapView: MGLMapView, fillColorForPolygonAnnotation annotation: MGLPolygon) -> UIColor {
        return UIColor.red.withAlphaComponent(0.5)
    }
    
    func mapView(_ mapView: MGLMapView, didUpdate userLocation: MGLUserLocation?) {
//        print(" xxx --> \(String(describing: userLocation?.location?.coordinate.latitude)) - \(String(describing: userLocation?.location?.coordinate.longitude))");
    }
    
//    func mapViewUserLocationAnchorPoint(_ mapView: MGLMapView) -> CGPoint {
//        <#code#>
//    }
}
