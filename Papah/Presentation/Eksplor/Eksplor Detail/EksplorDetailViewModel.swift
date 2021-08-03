//
//  EksplorDetailViewModel.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit
import CoreLocation
import Combine

class EksplorDetailViewModel {
    
    var wbklData: Wbkl?
    var singleEarningData: [Int] = []
    
    var onClaimPointReady = CurrentValueSubject<Bool,Never>(false)
    var distanceMeter = 0.0
    var totalEarnings = 0
    
    init(wbklData: Wbkl) {
        self.wbklData = wbklData
        initDataEarning()
        
        checkClaimPoint()
    }
    
    func initDataEarning() {
        if let data = self.wbklData?.wasteAccepted?.allObjects {
            for _ in data {
                self.singleEarningData.append(0)
            }
        }
    }
    
    func checkClaimPoint(){
        
        //        DispatchQueue.main.async {
        var currentCondition = false
        
        let hour = Calendar.current.dateComponents([.hour], from:self.wbklData?.claimed_date ?? Date(), to: Date()+1000).hour ?? 0
        
        if self.distanceMeter < 50 && //First condition (location)
            hour > 3 && //Second condition (hour)
            self.totalEarnings > 0 //Last condition (earning estimate)
        {
            currentCondition = true
        }
        
        self.onClaimPointReady.send(currentCondition)
        //        }
        
        
    }
    
    func getWasteAcceptedData() -> [WasteAccepted]? {
        return self.wbklData?.wasteAccepted?.allObjects as? [WasteAccepted]
    }
    
    func distanceBetweenTwoLocations(source:CLLocation, destination:CLLocation) -> Double {
        
        let distanceMeters = source.distance(from: destination)
        let distanceKM = distanceMeters / 1000
        let roundedTwoDigit = distanceKM.rounded()
        
        self.distanceMeter = distanceMeters
        self.checkClaimPoint()
        
        return roundedTwoDigit
        
    }
    
    func getEarningTotal() -> Int {
        totalEarnings = 0
        for earnings in self.singleEarningData {
            totalEarnings += earnings
        }
        
        checkClaimPoint()
        
        return totalEarnings
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
