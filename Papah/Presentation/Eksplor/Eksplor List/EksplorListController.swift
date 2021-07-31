//
//  EksplorListController.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

class EksplorListController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let strings = ["asdfefsa", "hahahah", "xoxoxoox"]
    var searchBarCont = UISearchController()
    var filteredData: [String] = []
    var filterStrings: [String] = []
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibTable = UINib(nibName: "ExplorListTableCell", bundle: nil)
        tableViewOutlet.register(nibTable, forCellReuseIdentifier: "ExplorListTableCell")
        
        let nibColl = UINib(nibName: "EksplorListCollectionCell", bundle: nil)
        collectionViewOutlet.register(nibColl, forCellWithReuseIdentifier: "EksplorListCollectionCell")
        
        collectionViewOutlet.delegate = self
        collectionViewOutlet.dataSource = self
        collectionViewOutlet.showsHorizontalScrollIndicator = false
        
        filteredData = strings
        filterStrings = ["asdas", "asdasda"] // "asdasd"]
        
        navigationItem.searchController = searchBarCont
        self.searchBarCont.searchBar.setValue("Batalkan", forKey: "cancelButtonText")
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    // MARK: - TableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExplorListTableCell", for: indexPath) as? ExplorListTableCell else {fatalError("identifiernya salah anying")}
        
        cell.wbklNameLabel.text = "test test hah hihi"
        cell.wbklCategoryLabel.text = "Tukang loak sejati"
        
        let categories = ["asfaf", "asdasdas", "aasdasdsdasda", "asdasd", "asdaqeqwe", "213"]
        var putihputih = [cell.wbklSampahKategori1, cell.wbklSampahKategori2, cell.wbklSampahKategori3, cell.wbklSampahKategori4]
        let textPutihPutih = [cell.wbklSampahKateogri1Label, cell.wbklSampahKategori2Label, cell.wbklSampahKategori3Label, cell.wbklSampahKategori4Label]
        
        
        
        for int in 0..<categories.count {
            if int < 3 {
                textPutihPutih[int]?.text = categories[int]
            } else {
                    textPutihPutih[3]?.text = "+\(categories.count-3)"
            }
        }
        
        for int in 0..<categories.count {
            if int < 4 {
                putihputih.remove(at: 0)
            }
        }
        
        for putih in putihputih {
            putih?.removeFromSuperview()

        }
        
        return cell
    }

    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let wbklData = WBKL(name: "nama", lng: 1, lat: 2, img: UIImage.whatsAppImage20210719At085013.jpegData(compressionQuality: 1.0) ?? Data(), operationalDay: "08:00", operationalHour: "08:00", address: "213", phoneNumber: "123")
                
        self.navigationController?.pushViewController(EksplorDetailController(viewModel: EksplorDetailViewModel(wbklData: wbklData)).instantiateStoryboard(), animated: true)
        
    }

// MARK: - CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EksplorListCollectionCell", for: indexPath) as? EksplorListCollectionCell else {
            fatalError("salah identifier si collection")
        }
        
        if indexPath.row == 1 {
            print("yey")
            cell.categoryLabel.text = "yadyadyaydaydya"
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? EksplorListCollectionCell else {fatalError("cugs")}
        
        if cell.categoryBubble.backgroundColor == .red {
            cell.categoryBubble.backgroundColor = .clear
        } else {
            cell.categoryBubble.backgroundColor = .red
        }
        
        
    }
}


//extension EksplorListController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func setupCollectionView() {
//        collectionView?.showsHorizontalScrollIndicator = false
//
//        collectionView.delegate = self
//        collectionView.dataSource = self
//
//        collectionView?.register(UINib(nibName: MedicineTableCellItem.identifier, bundle: nil), forCellWithReuseIdentifier: MedicineTableCellItem.identifier)
//        collectionView.reloadData()
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        if isHistory {
//            return medicineBaskets.count
//        } else {
//            return medicineLibrary?.count ?? 1
//        }
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellId, for: indexPath) as? MedicineTableCellItem else {
//            return UICollectionViewCell()
//        }
//
//        if isHistory {
//            if indexPath.row == medicineBaskets.count - 1 {
//                cell.viewDivider.isHidden = true
//            } else {
//                cell.viewDivider.isHidden = false
//            }
//            cell.medicineBasket = medicineBaskets[indexPath.row]
//
//        } else {
//            if indexPath.row == (medicineLibrary?.count ?? 1) - 1 {
//                cell.viewDivider.isHidden = true
//            } else {
//                cell.viewDivider.isHidden = false
//            }
//            cell.medicineEntries = medicineEntries
//            cell.medicineItem = medicineLibrary?[indexPath.row]
//
//        }
//        cell.backgroundColor = .red
//        return cell
//    }
//
//}
//




// MARK: - Kuburan

//    func setupFilter() {
//        var filterViews = [filter1, filter2, filter3]
//        var filterLabels = [filter1Label, filter2Label, filter3Label]
//        var filterButtons = [filter1Button, filter2Button, filter3Button]
//
//        if filterStrings.count != 0 {
//            filterUtama.borderWidth = 1
//            filterUtama.backgroundColor = filter1.backgroundColor
//            filterUtama.borderColor = .iconIolite
//            filterUtamaLabel.textColor = .iconIolite
//            filterUtamaLabel.text = "Yahud"
//        } else {
//            filterUtama.borderColor = .disabled
//            filterUtamaLabel.textColor = .black
//            filterUtamaLabel.text = "Yahud"
//        }
//
//        for int in 0..<filterStrings.count {
//            if int < 3 {
//                filterLabels[int]?.text = filterStrings[int]
//            }
//            else {
//                    filterLabels[3]?.text = "+\(categories.count-3)"
//            }
//        }
//
//        for fView in filterViews {
//            fView?.alpha = 1
//        }
//
//        for int in 0..<filterStrings.count {
//            if int < 3 {
//                filterViews.remove(at: 0)
//            }
//        }
//
//        for fView in filterViews {
//            fView?.alpha = 0
//        }
//
//        for fView in filterViews {
//            view.addSubview(fView!)
//        }
//    }
