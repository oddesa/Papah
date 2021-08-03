//
//  EksplorListViewModel.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit
import CoreLocation

struct KangLoak {
    let name: String
    let jenis: String
    let jarak: String
    let kategori: [String]
    let operasional: String
}

class WbklJarak: WbklDataRepository {
    var jarak: Double
    let wbklData: Wbkl
    
    init(jarak: Double, wbkl: Wbkl ) {
        self.jarak = jarak
        self.wbklData = wbkl
    }
}

class EksplorListViewModel: NSObject {

    let wbklRepository = WbklDataRepository.shared
    
    func getWBklData() -> [Wbkl]? {
        return wbklRepository.getAllWbkl()
    }
    
//    func getWbklCategory (wbkl: Wbkl) {
//        return
//    }
    

    
    
    // MARK: - Sorter
    func sortBasedOnDistance(wbklJaraks: [WbklJarak]) -> [WbklJarak] {
        let sortedWbklJarak = wbklJaraks.sorted {
            $0.jarak < $1.jarak
        }
        return sortedWbklJarak
    }
    
    // MARK: - Turn to WbklJarak
    func turnWbklsJarak() -> [WbklJarak] {
        
        guard let wbkls = getWBklData() else{fatalError("datanya ga keload")}
        var wbklsJarak: [WbklJarak] = []
        for wbkl in wbkls {
            let wbklJarak = WbklJarak(jarak: getLocationDistance(userLocation: (userLocation?.last ?? locationDummy), wbklData: wbkl), wbkl: wbkl)
            wbklsJarak.append(wbklJarak)
        }
        let sortedWbklsJarak = sortBasedOnDistance(wbklJaraks: wbklsJarak)
        return sortedWbklsJarak
    }
    
    // MARK: - Distance Logic
    let locationManager = CLLocationManager()
    var userLocation: [CLLocation]?
    
    let locationDummy = CLLocation(latitude: -6.636076, longitude: 106.804472)
    
    func distanceBetweenTwoLocations(source: CLLocation, destination: CLLocation) -> Double {
        let distanceMeters = source.distance(from: destination)
        let distanceKM = distanceMeters / 1000
        let roundedTwoDigit = distanceKM.rounded()
        return roundedTwoDigit
    }
    
    func getLocationDistance(userLocation: CLLocation, wbklData: Wbkl) -> Double {
            
            print("WBKL LOC \(wbklData.latitude) : \(wbklData.longitude)")
            print("USER LOC \(userLocation.coordinate.latitude) : \(userLocation.coordinate.longitude)")

            let targetLocation = CLLocation(latitude: Double(wbklData.latitude), longitude: Double(wbklData.longitude))
            let userLocation = CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)

            print("""
                user loc = \(userLocation)
                target loc = \(targetLocation)
                distance = \(distanceBetweenTwoLocations(source: targetLocation, destination: userLocation)) KM
                """)
            return distanceBetweenTwoLocations(source: targetLocation, destination: userLocation)
            

    }
    
    // MARK: - Buka Tutup Logic
    func extractNameOfTheDay() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "id_ID")
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: date)
        return dayInWeek
    }

    func extractHours() -> Int {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "id_ID")
        dateFormatter.dateFormat = "HH"
        let hourInDay = dateFormatter.string(for: date)
        return Int(hourInDay!)!
    }

    func extractMinutes() -> Int {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "id_ID")
        dateFormatter.dateFormat = "mm"
        let minutesInHour = dateFormatter.string(for: date)
        return Int(minutesInHour!)!
    }

    func countOperationalDay(text: String) -> Int {
        var splited = text.components(separatedBy: ["-", " "])
        splited = splited.filter {$0 != ""}
        return splited.count
    }

    func extractOperationalTime(operationalHour: String) -> [Int] {
        var splited = operationalHour.components(separatedBy: ["-", " ", "."])
        var operationalHourArray: [Int] = []
        splited = splited.filter {$0 != ""}
        for angka in splited {
            let integiii = Int(angka)
            operationalHourArray.append(integiii!)
        }
        return operationalHourArray
    }

    func timeChecker(operationalHour: String) -> Bool {
        let hourNow = extractHours()
        let minuteNow = extractMinutes()
        let openTimeArr = extractOperationalTime(operationalHour: operationalHour)
        if openTimeArr[0] < hourNow || (openTimeArr[0] == hourNow && openTimeArr[1] <= minuteNow) {
            if openTimeArr[2] > hourNow || (openTimeArr[2] == hourNow && openTimeArr[3] >= minuteNow) {
                return true
            } else {return false}
        } else {return false}
    }


    func bukaTutupChecker(operationalDay: String, operationalHour: String) -> Bool {
        if countOperationalDay(text: operationalDay) == 1 {
            let dayName = extractNameOfTheDay()
            if operationalDay == dayName {
                return timeChecker(operationalHour: operationalHour)
            } else {return false}
        } else {
            //ini karena senin - minggu tok
            let daysOfTheWeek = ["Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu", "Minggu"]
            let dayName = extractNameOfTheDay()
            if daysOfTheWeek.contains(dayName) {
                return timeChecker(operationalHour: operationalHour)
            } else {return false}
        }
    }
}
