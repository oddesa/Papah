//
//  EksplorListFilterViewModel.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

class CategoryPro {
    var isSelected: Bool = false
    let categoryData: WasteCategory
    
    init(category: WasteCategory ) {
        self.categoryData = category
    }
}

class EksplorListFilterViewModel: NSObject {

    let wbklRepository = WbklDataRepository.shared
    var filterData = [CategoryPro]()
    var dataPassingan = [WasteCategory]()
    
    func getAllWasteCategory() -> [WasteCategory]? {
        let categories = wbklRepository.getAllWasteCategory()
        return removeDuplicatesCategories(categories: categories)
    }
    
    func resetFilterData() {
        // swiftlint:disable identifier_name
        for i in 0..<(filterData.count) {
            // swiftlint:enable identifier_name
            if filterData[i].isSelected == true {
                filterData[i].isSelected = false
            }
        }
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
    
    
    func turnCategoriesPro() -> [CategoryPro] {
        guard let categories = getAllWasteCategory() else{fatalError("datanya ga keload")}
        var categoriesPro: [CategoryPro] = []
        for cat in categories {
            let catPro = CategoryPro(category: cat)
            categoriesPro.append(catPro)
        }
        return categoriesPro
    }
    
    
}
