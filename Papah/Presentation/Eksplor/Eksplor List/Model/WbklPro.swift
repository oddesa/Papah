//
//  WbklPro.swift
//  Papah
//
//  Created by Dhiky Aldwiansyah on 28/08/21.
//

import Foundation

class WbklPro {
    var jarak: Double
    let wbklData: Wbkl
    var categories: [String]
    
    init(jarak: Double, wbkl: Wbkl, categories: [String] ) {
        self.jarak = jarak
        self.wbklData = wbkl
        self.categories = categories
    }
    
    func getJarakInKm() -> Double {
        return jarak / 1000
    }
    
    func getJarakInString() -> String {
        
        if jarak >= 1000 {
            let distanceInKM = jarak / 1000
            let distanceInKMRounded = distanceInKM.rounded()
            return " · \(String.init(format: "%.0f", distanceInKMRounded))km"
        }
        else {
            jarak = jarak.rounded()
            
            if jarak == 0 {
                return ""
            } else {
                return " · \(String.init(format: "%.0f", jarak))m".replacingOccurrences(of: "0.", with: "")
            }
        }
    }
}
