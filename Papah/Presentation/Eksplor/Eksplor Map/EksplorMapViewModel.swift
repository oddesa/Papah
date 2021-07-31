//
//  EksplorMapViewModel.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit
import CoreLocation
import Combine

class EksplorMapViewModel: NSObject {
    
    init(dummy: Int){
        
    }
    
    var onAddressString = PassthroughSubject<String, Never>()
    
    func setAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center: CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude: center.latitude, longitude: center.longitude)
        
        ceo.reverseGeocodeLocation(loc, completionHandler: { (placemarks, error) in
                                        if error != nil {
                                            print("reverse geodcode fail: \(error!.localizedDescription)")
                                        }
                                        let plcmks = placemarks! as [CLPlacemark]
                                        
                                        if plcmks.count > 0 {
                                            let plcmks = placemarks![0]
//                                            print(pm.country)
//                                            print(pm.locality)
//                                            print(pm.subLocality)
//                                            print(pm.thoroughfare)
//                                            print(pm.postalCode)
//                                            print(pm.subThoroughfare)
                                            var addressString: String = ""
                                            if plcmks.subLocality != nil {
                                                addressString += plcmks.subLocality! + ", "
                                            }
                                            if plcmks.thoroughfare != nil {
                                                addressString += plcmks.thoroughfare! + ", "
                                            }
                                            if plcmks.locality != nil {
                                                addressString += plcmks.locality! + ", "
                                            }
                                            if plcmks.country != nil {
                                                addressString += plcmks.country! + ", "
                                            }
                                            if plcmks.postalCode != nil {
                                                addressString += plcmks.postalCode! + " "
                                            }
                                            
                                            self.onAddressString.send(addressString)
                                            
                                            print(addressString)
                                        }
                                    })
        
    }
}
