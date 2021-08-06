//
//  EksplorMapController.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit
import CoreLocation
import MapKit

extension EksplorMapController: CLLocationManagerDelegate {
    
    func attemptLocationAccess() {
        guard CLLocationManager.locationServicesEnabled() else {
            return
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
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
        
        locationManager.requestLocation()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        mapView.delegate = self
        
        centerMapOnUserLocation()
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
        
        //        centerMapOnUserLocation()
        
        //        if let firstLocation = locations.last {
        //           viewModel.setAddressFromLatLon(pdblLatitude: "\(firstLocation.coordinate.latitude)", withLongitude: "\(firstLocation.coordinate.longitude)")
        //            let destinationLocation = CLLocationCoordinate2D(latitude: 37.323, longitude: -122.03218)
        //            updateRouteView(startCoordinate: firstLocation.coordinate, endCoordinate: destinationLocation)
        //        }
        //
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let err = error as? CLError, err.code == .denied {
            manager.stopUpdatingLocation()
            return
        }
        print("\nlocationManager(): \(error.localizedDescription)")
    }
    
}


extension EksplorMapController: MKMapViewDelegate {
    
    func centerMapOnUserLocation() {
        guard let coordinate = locationManager.location?.coordinate else {return}
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(coordinateRegion, animated: true)
        
        viewModel?.setAddressFromLatLon(pdblLatitude: "\(coordinate.latitude)", withLongitude: "\(coordinate.longitude)")
    }
    
    func createPath(sourceLocation: CLLocationCoordinate2D, destinationLocation: CLLocationCoordinate2D) {
        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        let sourceAnotation = MKPointAnnotation()
        sourceAnotation.title = "Me"
        sourceAnotation.subtitle = "Papah"
        if let location = sourcePlaceMark.location {
            sourceAnotation.coordinate = location.coordinate
        }
        
        let destinationAnotation = MKPointAnnotation()
        destinationAnotation.title = self.viewModel?.wbklData?.name ?? ""
        destinationAnotation.subtitle = self.viewModel?.wbklData?.wbkl_type ?? ""
        if let location = destinationPlaceMark.location {
            destinationAnotation.coordinate = location.coordinate
        }
        
        self.mapView.showAnnotations([sourceAnotation, destinationAnotation], animated: true)
        
        updateRouteView(startCoordinate: sourceLocation, endCoordinate: destinationLocation)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "marker")
        annotationView.markerTintColor = .iconIolite
        annotationView.glyphImage = UIImage(systemName: "star.fill")
        return annotationView
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
        
        let direction = MKDirections(request: directionRequest)
        
        
        direction.calculate { (response, error) in
            guard let response = response else {
                if let error = error {
                    print("ERROR FOUND : \(error.localizedDescription)")
                }
                return
            }
            
            let route = response.routes[0]
            self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer{
        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        polylineRenderer.strokeColor = .iconIolite
        polylineRenderer.lineWidth = 4
        return polylineRenderer
    }
    
}
