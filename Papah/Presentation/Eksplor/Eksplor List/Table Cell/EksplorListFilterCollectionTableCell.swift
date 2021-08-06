//
//  EksplorListFilterCollectionTableCell.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 31/07/21.
//

import UIKit

class EksplorListFilterCollectionTableCell: UITableViewCell {

    var onDidSelectItem: (() -> ())?
    var onDidSelectItemSecond: ((CategoryPro) -> ())?
    var filterPassingan = [WasteCategory]() {
        didSet {
            collectionViewOtl.reloadData()
        }
    }
    var guardianIndex = [false, false, false, false, false]
    
    private var categories = [CategoryPro]()
    let wbklRepository = WbklDataRepository.shared
    
    @IBOutlet weak var filterBtn: DesignableButton!
    
    @IBOutlet weak var collectionViewOtl: UICollectionView!
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        categories = turnCategoriesPro()
    }
    
    
    
    func getAllWasteCategory() -> [WasteCategory]? {
        let categories = wbklRepository.getAllWasteCategory()
        return removeDuplicatesCategories(categories: categories)
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
    
    
    
   

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
   
    
    @IBAction func filterBtnPressed(_ sender: Any) {
        self.onDidSelectItem?()
    }
    
    
}
 // MARK: - CollectionView Configuration
extension EksplorListFilterCollectionTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setupCollectionView() {
        let nibColl = UINib(nibName: "EksplorListCollectionCell", bundle: nil)
        collectionViewOtl.register(nibColl, forCellWithReuseIdentifier: "EksplorListCollectionCell")
        
        collectionViewOtl.delegate = self
        collectionViewOtl.dataSource = self
        
        collectionViewOtl.showsHorizontalScrollIndicator = false
        
        collectionViewOtl.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if categories.count > 5 {
            return 5
        } else {
            return categories.count
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/3.0
        let yourHeight = collectionView.bounds.height

        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EksplorListCollectionCell", for: indexPath) as? EksplorListCollectionCell else {
            fatalError("salah identifier si collection")
        }
        
        if filterPassingan.contains(categories[indexPath.row].categoryData) {
            cell.isActive = true
            print("-------------------aaaa kepassing tapi active -----------------")
        } else {
            guardianIndex[indexPath.row] = false
            cell.isActive = false
            print("-------------------aaaa kepassing false-----------------")
        }
        
        let title = (categories[indexPath.row].categoryData.title ?? "mantan")
        cell.categoryBtn.setTitle(title, for: .normal)
        
        
        //wubuker
        switch title {
        case "Kertas":
            cell.categoryBtn.setImage(UIImage(systemName: "newspaper"), for: .normal)
        case "Kardus":
            cell.categoryBtn.setImage(UIImage(systemName: "shippingbox"), for: .normal)
        case "Perabotan":
            cell.categoryBtn.setImage(UIImage(systemName: "bed.double"), for: .normal)
        default:
            cell.categoryBtn.setImage(UIImage(systemName: "line.horizontal.3.decrease.circle"), for: .normal)
        }
        cell.categoryBtn.scalesLargeContentImage = false

        cell.onDidSelectItem  = { () in
            self.onDidSelectItemSecond?(self.categories[indexPath.row])
            print("ieu ajibbb")
        }
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        guard let cell = collectionView.cellForItem(at: indexPath) as? EksplorListCollectionCell else {fatalError("cugs")}
////        cell.onDidSelectItem  = { () in
////            print("ieu ajibbb")
////        }
//
//
//
//
//    }
}
