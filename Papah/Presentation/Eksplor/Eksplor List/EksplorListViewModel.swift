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
    var allWbkl = [WbklPro]()
    
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
                              filterCategories: [WasteCategory]) -> [WbklPro] {
        
        var allWbkl = [WbklPro]()
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
            print(textName.count)
            if (wbkl.wbklData.name?.lowercased().contains(textName.lowercased()))!  {
                let idx = allWbkl.firstIndex(where: { $0 === wbkl })
                allWbkl = (rearrangeArray(array: allWbkl, fromIndex: idx!, toIndex: 0))
            }
        }
        return allWbkl
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
                if !(wbkl.categories.contains(category.title!)) {
                    if let idx = dataWbkl.firstIndex(where: { $0 === wbkl }) {
                        dataWbkl.remove(at: idx)
                    }
                }
            }
        }
        return dataWbkl
    }
    // MARK: - Update Wbkl to WbklPro
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
    let locationDummy = CLLocation(latitude: -6.636076, longitude: 106.804472)
    var userLocation: [CLLocation]?
    
    func getLocationDistance(userLocation: CLLocation, wbklData: Wbkl) -> Double {
            
        let targetLocation = CLLocation(latitude: Double(wbklData.latitude), longitude: Double(wbklData.longitude))
        let userLocation = CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        
        return targetLocation.distance(from: userLocation)
    }
    
    func locationDistanceString(distanceInMeter: Double) -> String {
        var distanceInMeter = distanceInMeter
        var distanceInString: String
        if distanceInMeter >= 1000 {
            let distanceInKM = distanceInMeter / 1000
            let distanceInKMRounded = distanceInKM.rounded()
            distanceInString = "\(distanceInKMRounded) km"
        }
        else {
            distanceInMeter = distanceInMeter.rounded()
            distanceInString = "\(distanceInMeter) m"
        }
        return distanceInString
    }
}
