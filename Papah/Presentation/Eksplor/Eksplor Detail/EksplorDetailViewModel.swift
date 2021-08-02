//
//  EksplorDetailViewModel.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit
import CoreLocation

class EksplorDetailViewModel {
    
    var wbklData: Wbkl?
    
    init(wbklData: Wbkl) {
        self.wbklData = wbklData
    }
    
    func distanceBetweenTwoLocations(source:CLLocation,destination:CLLocation) -> Double{
        
        let distanceMeters = source.distance(from: destination)
        let distanceKM = distanceMeters / 1000
        let roundedTwoDigit = distanceKM.rounded()
        return roundedTwoDigit
        
    }
    
    func getLocationDistance(userLocation: CLLocation) -> Double {
        
        if let wbklData = wbklData {
            
            print("WBKL LOC \(wbklData.latitude) : \(wbklData.longitude)")
            print("USER LOC \(userLocation.coordinate.latitude) : \(userLocation.coordinate.longitude)")

            let targetLocation = CLLocation(latitude:Double(wbklData.latitude), longitude: Double(wbklData.longitude))
            let userLocation = CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)

            print("""
                user loc = \(userLocation)
                target loc = \(targetLocation)
                distance = \(distanceBetweenTwoLocations(source: targetLocation, destination: userLocation)) KM
                """)
            
            return distanceBetweenTwoLocations(source: targetLocation, destination: userLocation)
            
        }
        
        return 0

    }
}
