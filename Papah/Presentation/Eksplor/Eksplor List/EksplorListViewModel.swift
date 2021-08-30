//
//  EksplorListViewModel.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit
import CoreLocation
import MapKit
import Combine

class EksplorListViewModel: NSObject {
    
    let wbklRepository = WbklDataRepository.shared
    var allWbkl = [WbklPro]()
    var filteredWbkl = [WbklPro]()
    var filterCategories: [WasteCategory] = []
    
    var isItEmptyState = CurrentValueSubject<Bool,Never>(false)
    
    // MARK: - Distance Logic
    let locationManager = CLLocationManager()
    var userLocation: [CLLocation]?
    
    func getWbklBasedOnSearch(text: String,
                              filterCategories: [WasteCategory]) {
        
        let splited = text.components(separatedBy: " ")
        
        if text.count != 0 {
                        
            filteredWbkl = allWbkl.filter {
                if let name = $0.wbklData.name {
                    for word in splited {
                        let nameCheck = name.lowercased().contains(word.lowercased())
                        let categoryCheck = !$0.categories.filter { $0.lowercased().contains(word.lowercased()) }.isEmpty
                        if nameCheck || categoryCheck {
                            if let index = $0.categories.firstIndex(of: word.capitalized) {
                                $0.categories = rearrangeArray(array: $0.categories, fromIndex: index, toIndex: 0)
                            }
                            return true
                        }
                    }
                }
                return false
            }
            
            self.wbklCategoryFiltered(withSearch: true)
            
//            for wbkl in allWbkl {
//
//                let nameCheck = (wbkl.wbklData.name ?? "").lowercased().contains(text.lowercased())
//                let categoryCheckText = (categoriesChecker(wbkl: wbkl, word: text))
//
//                if nameCheck && categoryCheckText {
//
//                    if let index = wbkl.categories.firstIndex(of: text.capitalized) {
//                        wbkl.categories = rearrangeArray(array: wbkl.categories, fromIndex: index, toIndex: 0)
//                    }
//
//                    filteredWbkl.append(wbkl)
//                } else {
//                    for word in splited {
//
//                        let categoryCheckWord = (categoriesChecker(wbkl: wbkl, word: word))
//
//                        if nameCheck && categoryCheckWord {
//                            if let index = wbkl.categories.firstIndex(of: word.capitalized) {
//                                wbkl.categories = rearrangeArray(array: wbkl.categories, fromIndex: index, toIndex: 0)
//                            }
//                            filteredWbkl.append(wbkl)
//                        }
//                    }
//                }
//            }
            
        }
        
//        for wbkl in allWbkl {
//            var textName = text
//
//            for word in splited {
//                if (categoriesChecker(wbkl: wbkl, word: word)) {
//                    textName = textName.lowercased().replacingOccurrences(of: " \(word.lowercased())", with: "")
//                    textName = textName.lowercased().replacingOccurrences(of: "\(word.lowercased()) ", with: "")
//                    if let index = wbkl.categories.firstIndex(of: word.capitalized) {
//                        wbkl.categories = rearrangeArray(array: wbkl.categories, fromIndex: index, toIndex: 0)
//                    }
//                }
//            }
//            if (wbkl.wbklData.name?.lowercased().contains(textName.lowercased())) ?? false  {
//                let idx = allWbkl.firstIndex(where: { $0 === wbkl })
//                filteredWbkl = (rearrangeArray(array: allWbkl, fromIndex: idx ?? 0, toIndex: 0))
//            }
//        }
        
        print("FILTERED WBKL \(filteredWbkl.count)")

        if self.filteredWbkl.count == 0 {
            self.isItEmptyState.send(true)
        } else {
            self.isItEmptyState.send(false)
        }
        
    }
    
    //MARK: KEN ASINKRONUS
    // MARK: - Update Wbkl to WbklPro
    func setupWbklProData(){
        
        if allWbkl.isEmpty {
            for wbkl in wbklRepository.getAllWbkl() {
                let wbklPro = WbklPro(jarak: 0, wbkl: wbkl, categories: self.getWbklCategoriesName(wbkl: wbkl))
                allWbkl.append(wbklPro)
            }
            filteredWbkl = allWbkl
        } else {
            filteredWbkl = allWbkl
        }
        
        if self.filteredWbkl.count == 0 {
            self.isItEmptyState.send(true)
        } else {
            self.isItEmptyState.send(false)
        }
        
    }
    
    func updateWbklDistance(completion: ( () -> Void)? = nil){

        var locationCount = 0

        if let userLocation = userLocation?.last {
            for (index, data) in self.allWbkl.enumerated() {
                getLocationDistance(wbklPro: data, userLocation:  userLocation) { jaraDbl in
                    
                    locationCount += 1

                    if jaraDbl != 0 {
                        self.allWbkl[index].jarak = jaraDbl
                    }
                                    
                    if locationCount == self.allWbkl.count {
                        let sortedWbklsJarak = self.sortBasedOnDistance(wbklPros: self.allWbkl)
                        self.allWbkl = sortedWbklsJarak
                        self.filteredWbkl = sortedWbklsJarak
                        completion?()
                    }
                }
            }
            
        }
        else {
            for (index, _) in self.allWbkl.enumerated() {
                self.allWbkl[index].jarak = 0
            }
            let sortedWbklsJarak = self.sortBasedOnDistance(wbklPros: self.allWbkl)
            self.allWbkl = sortedWbklsJarak
            self.filteredWbkl = sortedWbklsJarak
            completion?()
        }
    }
    
    func wbklCategoryFiltered(withSearch: Bool) {
        self.filteredWbkl = self.filterBasedOnCat(withSearch: withSearch)
        
        if self.filteredWbkl.count == 0 {
            self.isItEmptyState.send(true)
        } else {
            self.isItEmptyState.send(false)
        }
        
        print("FILTERED WBKL \(filteredWbkl.count)")
    }
    
}

extension EksplorListViewModel {
    
    func rearrangeArray<T>(array: Array<T>, fromIndex: Int, toIndex: Int) -> Array<T> {
        var arr = array
        let element = arr.remove(at: fromIndex)
        arr.insert(element, at: toIndex)
        return arr
    }
    
    // MARK: - Search Logic
    func categoriesChecker(wbkl: WbklPro, word: String) -> Bool {
        let categoryData = wbkl.categories.filter { $0.lowercased().contains(word.lowercased()) }
        return !categoryData.isEmpty
    }
    
    // MARK: - Get WBKL Categories name
    func getWbklCategoriesName (wbkl: Wbkl) -> [String] {
        guard let categoriesData = wbkl.wasteAccepted?.allObjects as? [WasteAccepted] else {return [" "]}
        var categoriesString: [String] = []
        for category in categoriesData {
            categoriesString.append(category.wasteCategory?.title ?? "Mantan")
        }
        return categoriesString
    }
    
    // MARK: - Sorter Filter Logic
    func sortBasedOnDistance(wbklPros: [WbklPro]) -> [WbklPro] {
        let sortedWbklJarak = wbklPros.sorted {
            $0.jarak < $1.jarak
        }
        return sortedWbklJarak
    }
    
    // Filter category
    func filterBasedOnCat(withSearch: Bool) -> [WbklPro]{
        
        let wbklData: [WbklPro] = withSearch ? self.filteredWbkl : self.allWbkl
        
        let filteredWbkl =  wbklData.filter { (wbkl) -> Bool in
            let wbklCategory = wbkl.categories.map({ $0 })
            let filteredCategories = self.filterCategories.map({$0.title ?? ""})
            return filteredCategories.allSatisfy(wbklCategory.contains)
        }
        return filteredWbkl
    }
    
    
    //MARK: KEN ASINKRONUS
    func getLocationDistance(wbklPro: WbklPro?, userLocation: CLLocation, completion: @escaping (Double) -> Void ) {
        if let wbklData = wbklPro?.wbklData {
            
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
                        completion(0.0)
                        print("No Route Found : \(error.localizedDescription)")
                    }
                    return
                }
                
                print("Route Check \(response.routes)")

                if response.routes.count < 1 {
                    completion(0.0)
                } else {
                    let distanceInMeter = response.routes[0].distance
                    completion(distanceInMeter)
                }
            }
        }
        
    }
}
