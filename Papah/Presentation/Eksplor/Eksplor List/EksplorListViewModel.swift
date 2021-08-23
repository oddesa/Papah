//
//  EksplorListViewModel.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit
import CoreLocation
import MapKit

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
    var allWbkl = [WbklPro]()
    
    func getWBklData() -> [Wbkl]? {
        return wbklRepository.getAllWbkl()
    }
    
    func getAllWasteCategory() -> [WasteCategory] {
        return wbklRepository.getAllWasteCategory()
    }
    
    func getWbklCategoriesName (wbkl: Wbkl) -> [String] {
        guard let categoriesData = wbkl.wasteAccepted?.allObjects as? [WasteAccepted] else {return [" "]}
        var categoriesString: [String] = []
        for category in categoriesData {
            categoriesString.append(category.wasteCategory?.title ?? "Mantan")
        }
        return categoriesString
    }
    
    
    
    // MARK: - Search Logic
    
    func categoriesChecker(wbkl: WbklPro, word: String) -> Bool {
        for category in wbkl.categories {
            if category.lowercased().contains(word.lowercased()) {
                return true
            }
        }
        return false
    }
    
    func getWbklBasedOnSearch(text: String, dataWbkl: [WbklPro],
                              filterCategories: [WasteCategory]) {
        
        let splited = text.components(separatedBy: " ")
    
        if text.count == 0 {
            if filterCategories.count == 0 {
                allWbkl = []
            } else {
                allWbkl = dataWbkl
            }
        } else {
            allWbkl = []
            for wbkl in dataWbkl {
                if (wbkl.wbklData.name ?? "").lowercased().contains(text.lowercased()) || (categoriesChecker(wbkl: wbkl, word: text)) {
                    print(text.lowercased())
                    
                    if (categoriesChecker(wbkl: wbkl, word: text)) {
                        if let index = wbkl.categories.firstIndex(of: text.capitalized) {
                            wbkl.categories = rearrangeArray(array: wbkl.categories, fromIndex: index, toIndex: 0)
                        }
                    }
                    
                    allWbkl.append(wbkl)
                } else {
                    for word in splited {
                        if (wbkl.wbklData.name ?? "").lowercased().contains(word.lowercased()) || (categoriesChecker(wbkl: wbkl, word: word)) {
                            print(word.lowercased())
                            
                            if (categoriesChecker(wbkl: wbkl, word: word)) {
                                if let index = wbkl.categories.firstIndex(of: word.capitalized) {
                                    wbkl.categories = rearrangeArray(array: wbkl.categories, fromIndex: index, toIndex: 0)
                                }
                            }
                            allWbkl.append(wbkl)
                        }
                    }
                }
            }
        }
        allWbkl = (removeDuplicatesWbkl(wbklPros: allWbkl))
        for wbkl in allWbkl {
            var textName = text
            
            for word in splited {
                if (categoriesChecker(wbkl: wbkl, word: word)) {
                    textName = textName.lowercased().replacingOccurrences(of: " \(word.lowercased())", with: "")
                    textName = textName.lowercased().replacingOccurrences(of: "\(word.lowercased()) ", with: "")
                    if let index = wbkl.categories.firstIndex(of: word.capitalized) {
                        wbkl.categories = rearrangeArray(array: wbkl.categories, fromIndex: index, toIndex: 0)
                    }
                }
            }
            if (wbkl.wbklData.name?.lowercased().contains(textName.lowercased())) ?? false  {
                let idx = allWbkl.firstIndex(where: { $0 === wbkl })
                allWbkl = (rearrangeArray(array: allWbkl, fromIndex: idx ?? 0, toIndex: 0))
            }
        }
    }
    
    // MARK: - Duplicate Remover Logic (non hashable)
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
    
    // MARK: - Sorter Filter Logic
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

    func filterBasedOnCat(allWbkl: [WbklPro], filterCategories: [WasteCategory]) -> [WbklPro]{
        var dataWbkl = allWbkl
        for wbkl in dataWbkl {
            for category in filterCategories {
                if !(wbkl.categories.contains(category.title ?? " ")) {
                    if let idx = dataWbkl.firstIndex(where: { $0 === wbkl }) {
                        dataWbkl.remove(at: idx)
                    }
                }
            }
        }
        return dataWbkl
    }
    

    //MARK: KEN ASINKRONUS
    // MARK: - Update Wbkl to WbklPro
    func turnWbklsPro(completion: @escaping ([WbklPro]) -> Void){
        guard let wbkls = getWBklData() else{fatalError("datanya ga keload")}
        var wbklsPro: [WbklPro] = []
        var locationCount = 0
//        let wbklDispatchGroup = DispatchGroup()

        for wbkl in wbkls {
//            wbklDispatchGroup.enter()
            getLocationDistance(wbklData: wbkl, userLocation:  (userLocation?.last ?? locationDummy)) { jarakStr,jaraDbl in
                let wbklPro = WbklPro(jarak: jaraDbl, wbkl: wbkl, categories: self.getWbklCategoriesName(wbkl: wbkl))
                wbklsPro.append(wbklPro)
                if wbklPro.categories.count == 0 {
                    fatalError("cuagas")
                }
                locationCount += 1
                print("current countt \(locationCount) && \(wbkls.count)")
                print("DISTANCE \(jaraDbl) srt \(jarakStr)")

                if locationCount == wbkls.count {
                    print("TEST LEAVE")
                    print("TEST WBKPRO \(wbklsPro)")
//                    self.wbklDispatchGroup.leave()
                    let sortedWbklsJarak = self.sortBasedOnDistance(wbklPros: wbklsPro)
                    completion(sortedWbklsJarak)
                }
            }
           
        }
        
//        wbklDispatchGroup.notify(queue: DispatchQueue.main) {
//            print("Finished all requests.")
//            print("TEST WBKPRO \(wbklsPro)")
//        }

    }

    //MARK: KEN ASINKRONUS
    func returnWbklsBasedOnCat(filterCategories: [WasteCategory], completion: ( () -> Void)? = nil ) {
        turnWbklsPro(completion: { data in
            self.allWbkl = data
            self.allWbkl = self.filterBasedOnCat(allWbkl: self.allWbkl, filterCategories: filterCategories)
            completion?()
        })
    }
    
    // MARK: - Distance Logic
    let locationManager = CLLocationManager()
    let locationDummy = CLLocation(latitude: -6.636076, longitude: 106.804472)
    var userLocation: [CLLocation]?
    
//    func getLocationDistance(userLocation: CLLocation, wbklData: Wbkl) -> Double {
//
//        let targetLocation = CLLocation(latitude: Double(wbklData.latitude), longitude: Double(wbklData.longitude))
//        let userLocation = CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
//
//        return targetLocation.distance(from: userLocation)
//    }
//
//    func locationDistanceString(distanceInMeter: Double) -> String {
//        var distanceInMeter = distanceInMeter
//        var distanceInString: String
//        if distanceInMeter >= 1000 {
//            let distanceInKM = distanceInMeter / 1000
//            let distanceInKMRounded = distanceInKM.rounded()
//            distanceInString = "\(distanceInKMRounded) km"
//        }
//        else {
//            distanceInMeter = distanceInMeter.rounded()
//            distanceInString = "\(distanceInMeter) m"
//        }
//        return distanceInString
//    }
    
    //MARK: KEN ASINKRONUS
    func getLocationDistance(wbklData: Wbkl?, userLocation: CLLocation, completion: @escaping (String, Double) -> Void ) {
        print("LAST LOC \(userLocation)")
        if let wbklData = wbklData {
            
            let targetLocation = CLLocationCoordinate2D(latitude:Double(wbklData.latitude), longitude: Double(wbklData.longitude))
            let userLocation = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
            
            let sourcePlaceMark = MKPlacemark(coordinate: userLocation, addressDictionary: nil)
            let destinationPlaceMark = MKPlacemark(coordinate: targetLocation, addressDictionary: nil)
            
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
                        completion("", 0.0)
                        print("No Route Found : \(error.localizedDescription)")
                    }
                    return
                }
                
                if response.routes.count < 1 {
                    print("RESPONSE RTOUREE eee")
                    completion("", 0.0)
                } else {
                    
                    var distanceInMeter = response.routes[0].distance
                    var distanceInString: String
                    if distanceInMeter >= 1000 {
                        let distanceInKM = distanceInMeter / 1000
                        let distanceInKMRounded = distanceInKM.rounded()
                        distanceInString = "\(String.init(format: "%.0f", distanceInKMRounded))km"
                    }
                    else {
                        distanceInMeter = distanceInMeter.rounded()
                        distanceInString = "\(String.init(format: "%.3f", distanceInMeter))m".replacingOccurrences(of: "0.", with: "")
                    }
                    completion(distanceInString, distanceInMeter)
                }
            }
        }
        
    }
}
