//
//  EksplorMapController.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit
import CoreLocation
import MapKit

extension EksplorDetailController: CLLocationManagerDelegate {
    
    func attemptLocationAccess() {
        guard CLLocationManager.locationServicesEnabled() else {
            return
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            requestLocationTracking()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            //Mesti popup user buat enable di phone settings
            break
        default:
            locationManager.requestLocation()
        }
        
    }
    
    func requestLocationTracking() {
        
        print("Sdasdsa")
        
//        locationManager.requestLocation()
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
////        locationManager.distanceFilter = kCLDistanceFilterNone
//        locationManager.startUpdatingLocation()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.distanceFilter = 10
//        mapView.showsUserLocation = true
//        mapView.userTrackingMode = .follow
    }
    

    func updateRouteView(startCoordinate: CLLocationCoordinate2D, endCoordinate: CLLocationCoordinate2D) {
        
        let sourcePlaceMark = MKPlacemark(coordinate: startCoordinate, addressDictionary: nil)
        let destinationPlaceMark = MKPlacemark(coordinate: endCoordinate, addressDictionary: nil)

        let sourceMapItem = MKMapItem(placemark: sourcePlaceMark)
        let destinationItem = MKMapItem(placemark: destinationPlaceMark)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationItem
        directionRequest.transportType = .automobile
        
//        let direction = MKDirections(request: directionRequest)
        
//        direction.calculate { (response, error) in
//            guard let response = response else {
//                if let error = error {
//                    print("ERROR FOUND : \(error.localizedDescription)")
//                }
//                return
//            }
//
//            let route = response.routes[0]
////            self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
//
////            let rect = route.polyline.boundingMapRect
//
////            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
//
//        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("\nStart of locationManager(didChangeAuthorization)")
        
        //        let authStatus = CLLocationManager.authorizationStatus()
        //        if authStatus == CLAuthorizationStatus.authorizedWhenInUse
        //            || authStatus == CLAuthorizationStatus.authorizedAlways {
        //            requestLocation()
        //        }
        
        print("\nEnd of locationManager(didChangeAuthorization)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("\nStart of locationManager(didUpdateLocations)")

        if let lastLocation = locations.last {
            self.distanceLocation = self.viewModel?.getLocationDistance(userLocation: lastLocation) ?? 0
            self.tableView.reloadSections(IndexSet(integer: sectionDetail), with: .automatic)
        }

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let err = error as? CLError, err.code == .denied {
            manager.stopUpdatingLocation()
            return
        }
        print("\nlocationManager(): \(error.localizedDescription)")
    }
}
