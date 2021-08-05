//
//  EksplorListViewModel.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit
import CoreLocation

class WbklPro: WbklDataRepository {
    var jarak: Double
    let wbklData: Wbkl
    var categories: [String]
    
    init(jarak: Double, wbkl: Wbkl, categories: [String] ) {
        self.jarak = jarak
        self.wbklData = wbkl
        self.categories = categories
    }
}

class EksplorListViewModel: NSObject {

    let wbklRepository = WbklDataRepository.shared
    
    func getWBklData() -> [Wbkl]? {
        return wbklRepository.getAllWbkl()
    }
    
    func getAllWasteCategory() -> [WasteCategory] {
        return wbklRepository.getAllWasteCategory()
    }
    
    func getWbklCategoriesName (wbkl: Wbkl) -> [String] {
        let categoriesData = wbkl.wasteAccepted?.allObjects as! [WasteAccepted]
        var categoriesString: [String] = []
        for category in categoriesData {
            categoriesString.append(category.wasteCategory?.title ?? "Mantan")
        }
        return categoriesString
    }
    
    func categoriesChecker(wbkl: WbklPro, word: String) -> Bool {
        for category in wbkl.categories {
            if category.lowercased().contains(word.lowercased()) {
                return true
            }
        }
        return false
    }

    
    func removeDuplicatesWbkl(wbklPros: [WbklPro]) -> [WbklPro] {
        var uniques = [WbklPro]()
        for wbkl in wbklPros {
            if !uniques.contains(where: {$0.wbklData.id == wbkl.wbklData.id}) {
                uniques.append(wbkl)
            }
        }
        return uniques
    }
    
    func removeDuplicatesCategories(categories: [WasteCategory]) -> [WasteCategory] {
        var uniques = [WasteCategory]()
        for cat in categories {
            if !uniques.contains(where: {$0.title == cat.title }) {
                uniques.append(cat)
            }
        }
        return uniques
    }
    
    // MARK: - Sorter
    func sortBasedOnDistance(wbklPros: [WbklPro]) -> [WbklPro] {
        let sortedWbklJarak = wbklPros.sorted {
            $0.jarak < $1.jarak
        }
        return sortedWbklJarak
    }

    
    func rearrangeArray<T>(array: Array<T>, fromIndex: Int, toIndex: Int) -> Array<T> {
        var arr = array
        let element = arr.remove(at: fromIndex)
        arr.insert(element, at: toIndex)
        return arr
    }
    
//    func becomeFirstCategory<T>(array: Array<T>, element: String) -> Array<T> {
//        guard let idx = array.firstIndex(where: { $0 === element }) else {return}
//        rearrangeArray(array: array, fromIndex: <#T##Int#>, toIndex: <#T##Int#>)
//    }
    
    // MARK: - Turn to WbklPro
    func turnWbklsPro() -> [WbklPro] {
        guard let wbkls = getWBklData() else{fatalError("datanya ga keload")}
        var wbklsPro: [WbklPro] = []
        for wbkl in wbkls {
            let wbklPro = WbklPro(jarak: getLocationDistance(userLocation: (userLocation?.last ?? locationDummy), wbklData: wbkl), wbkl: wbkl, categories: getWbklCategoriesName(wbkl: wbkl))
            wbklsPro.append(wbklPro)
            if wbklPro.categories.count == 0 {
                fatalError("cuagas")
            }
        }
        let sortedWbklsJarak = sortBasedOnDistance(wbklPros: wbklsPro)
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
            
//            print("WBKL LOC \(wbklData.latitude) : \(wbklData.longitude)")
//            print("USER LOC \(userLocation.coordinate.latitude) : \(userLocation.coordinate.longitude)")

            let targetLocation = CLLocation(latitude: Double(wbklData.latitude), longitude: Double(wbklData.longitude))
            let userLocation = CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)

//            print("""
//                user loc = \(userLocation)
//                target loc = \(targetLocation)
//                distance = \(distanceBetweenTwoLocations(source: targetLocation, destination: userLocation)) KM
//                """)
            return distanceBetweenTwoLocations(source: targetLocation, destination: userLocation)
            

    }
}
