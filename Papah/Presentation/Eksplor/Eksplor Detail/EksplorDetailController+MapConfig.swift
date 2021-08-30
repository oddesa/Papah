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
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.distanceFilter = 10
        
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

    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("\nStart of locationManager(didChangeAuthorization)")
        
        print("\nEnd of locationManager(didChangeAuthorization)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("\nStart of locationManager(didUpdateLocations)")

        if let lastLocation = locations.last {
            
            
//            self.viewModel?.distanceBetweenTwoLocations(source: lastLocation)
//            self.tableView.reloadSections(IndexSet(integer: self.sectionDetail), with: .none)
            self.viewModel?.getLocationDistance(userLocation: lastLocation, completion: { distance in
//                self.tableView.reloadSections(IndexSet(integer: self.sectionDetail), with: .none)
                self.tableView.reloadRows(at: [IndexPath(row: 0, section: self.sectionDetail)], with: .none)
            })
            
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
