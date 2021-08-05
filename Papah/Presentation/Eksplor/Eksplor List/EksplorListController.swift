//
//  EksplorListController.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit
import CoreLocation

class EksplorListController: MVVMViewController<EksplorListViewModel> {
    
    
    
    let strings = ["asdfefsa", "hahahah", "xoxoxoox"]
    var searchBarCont = UISearchController()
    var allWbkl: [WbklPro] = []
    var filterCategories: [WasteCategory] = []
    {
        didSet {
            allWbkl = viewModel?.turnWbklsPro() ?? []
            for wbkl in allWbkl {
                for category in filterCategories {
                    if !(wbkl.categories.contains(category.title!)) {
                        if let idx = allWbkl.firstIndex(where: { $0 === wbkl }) {
                            allWbkl.remove(at: idx)
                        }
                    }
                }
            }
            tableViewOutlet.reloadData()
        }
    }
    
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    private var loadingView: LoadingView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarItem.isEnabled = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = EksplorListViewModel()
        
//        loadingView = LoadingView(uiView: self.view, message: "")
//        loadingView.show()
        
        setupLocationManager()
        setupSearchController()
        setupNib()
        allWbkl = viewModel?.turnWbklsPro() ?? []
//        filterCategories = viewModel?.getAllWasteCategory() ?? []
        
        
//        filterCategories = viewModel?.removeDuplicatesCategories(categories: filterCategories) ?? []
//        for filter in filterCategories {
//            print(filter.title)
//            print(filterCategories.count)
//        }
        tableViewOutlet.reloadData()
    }
}

    // MARK: - UISearchController
extension EksplorListController: UISearchResultsUpdating, UISearchControllerDelegate {
    
    func setupSearchController() {
        navigationItem.searchController = searchBarCont
        searchBarCont.searchResultsUpdater = self
        searchBarCont.delegate = self
        searchBarCont.obscuresBackgroundDuringPresentation = false
        searchBarCont.searchBar.setValue("Batalkan", forKey: "cancelButtonText")
        searchBarCont.searchBar.placeholder = "Agen Sampah"
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        guard var dataWbkl = viewModel?.turnWbklsPro() else {return}
        for wbkl in dataWbkl {
            for category in filterCategories {
                if !(wbkl.categories.contains(category.title!)) {
                    if let idx = dataWbkl.firstIndex(where: { $0 === wbkl }) {
                        dataWbkl.remove(at: idx)
                    }
                }
            }
        }
        allWbkl = dataWbkl
        tableViewOutlet.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        let splited = text.components(separatedBy: " ")
        guard var dataWbkl = viewModel?.turnWbklsPro() else {return}
        for wbkl in dataWbkl {
            for category in filterCategories {
                if !(wbkl.categories.contains(category.title!)) {
                    if let idx = dataWbkl.firstIndex(where: { $0 === wbkl }) {
                        dataWbkl.remove(at: idx)
                    }
                }
            }
        }
        
        
        if text.count == 0 {
            allWbkl = []
        } else {
            allWbkl = []
            print("restart")
            for wbkl in dataWbkl {
                print("gantiWBKL")
                if (wbkl.wbklData.name ?? "").lowercased().contains(text.lowercased()) || (viewModel?.categoriesChecker(wbkl: wbkl, word: text))! {
                    print("keluarga cendana")
                    print(text.lowercased())
                    
                    if (viewModel?.categoriesChecker(wbkl: wbkl, word: text))! {
                        if let index = wbkl.categories.firstIndex(of: text.capitalized) {
                            wbkl.categories = viewModel?.rearrangeArray(array: wbkl.categories, fromIndex: index, toIndex: 0) ?? ["mantan"]
                        }
                    }
                    
                    allWbkl.append(wbkl)
                    print("keluarga cendana2")
//                    if let idx = dataWbkl.firstIndex(where: { $0 === wbkl }) {
//                        dataWbkl.remove(at: idx)
//                    }
                } else {
                    print("keluarga cendana3")
                    for word in splited {
                        if (wbkl.wbklData.name ?? "").lowercased().contains(word.lowercased()) || (viewModel?.categoriesChecker(wbkl: wbkl, word: word))! {
                            print(word.lowercased())
                            
                            if (viewModel?.categoriesChecker(wbkl: wbkl, word: word))! {
                                if let index = wbkl.categories.firstIndex(of: word.capitalized) {
                                    wbkl.categories = viewModel?.rearrangeArray(array: wbkl.categories, fromIndex: index, toIndex: 0) ?? ["mantan"]
                                }
                            }
                            allWbkl.append(wbkl)
//                            if let idx = dataWbkl.firstIndex(where: { $0 === wbkl }) {
//                                dataWbkl.remove(at: idx)
//                            }
                                                        
                        }
                    }
                }
            }
        }
        allWbkl = (viewModel?.removeDuplicatesWbkl(wbklPros: allWbkl))!
        for wbkl in allWbkl {
            var textName = text
            
            for word in splited {
                if (viewModel?.categoriesChecker(wbkl: wbkl, word: word))! {
                    textName = textName.lowercased().replacingOccurrences(of: " \(word.lowercased())", with: "")
                    textName = textName.lowercased().replacingOccurrences(of: "\(word.lowercased()) ", with: "")
//                    textName = textName.replacingOccurrences(of: "  ", with: " ")
                    if let index = wbkl.categories.firstIndex(of: word.capitalized) {
                        wbkl.categories = viewModel?.rearrangeArray(array: wbkl.categories, fromIndex: index, toIndex: 0) ?? ["mantan"]
                    }
                }
            }
            print(textName.count)
            if (wbkl.wbklData.name?.lowercased().contains(textName.lowercased()))!  {
                let idx = allWbkl.firstIndex(where: { $0 === wbkl })
                allWbkl = (viewModel?.rearrangeArray(array: allWbkl, fromIndex: idx!, toIndex: 0))!
            }
        }
//        for wbkl in allWbkl {
//            for word in splited {
//                if (viewModel?.categoriesChecker(wbkl: wbkl, word: word))! {
//                    if (wbkl.categories.contains(word)) {
//                        if let idx = allWbkl.firstIndex(where: { $0 === wbkl }) {
//                            allWbkl.remove(at: idx)
//                        }
//                    }
//                }
//            }
//        }
        
        tableViewOutlet.reloadData()
    }
    
    
    
}

    // MARK: - TableView DataSource
extension EksplorListController: UITableViewDataSource {
    func setupNib() {
        let nibTable = UINib(nibName: "ExplorListTableCell", bundle: nil)
        tableViewOutlet.register(nibTable, forCellReuseIdentifier: "ExplorListTableCell")
        let nibTable1 = UINib(nibName: "EksplorListFilterCollectionTableCell", bundle: nil)
        tableViewOutlet.register(nibTable1, forCellReuseIdentifier: "EksplorListFilterCollectionTableCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allWbkl.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //EksplorListFilterCollectionTableCell
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EksplorListFilterCollectionTableCell", for: indexPath) as? EksplorListFilterCollectionTableCell else {fatalError("identifiernya salah anying")}
            cell.onDidSelectItem = { () in
                let controller = EksplorListFilterController.instantiateStoryboard(viewModel: EksplorListFilterViewModel())
                self.navigationController?.present(controller, animated: true, completion: nil)
            }
            
            cell.onDidSelectItemSecond = { (category) in
                if !(self.filterCategories.contains(category.categoryData)) {
                    self.filterCategories.append(category.categoryData)
                } else {
                    self.filterCategories = self.filterCategories.filter {$0 != category.categoryData}
                }
                for cat in self.filterCategories {
                    print(cat.title!)
                }
            }
            
            if filterCategories.count == 0 {
                cell.filterBtn.borderWidth = 0.5
                cell.filterBtn.backgroundColor = .white
                cell.filterBtn.borderColor = .black
                cell.filterBtn.tintColor = .black
                cell.filterBtn.setTitleColor(.black, for: .normal)
                print("Bisa nih3")
            } else {
                cell.filterBtn.backgroundColor = .iconIolite.withAlphaComponent(0.15)
                cell.filterBtn.borderColor = .iconIolite.withAlphaComponent(0.6)
                cell.filterBtn.borderWidth = 0.5
                cell.filterBtn.tintColor = .iconIolite
                cell.filterBtn.setTitleColor(.iconIolite, for: .normal)
                print("Bisa nih2")
            }
            
            cell.selectionStyle = .none
            return cell
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExplorListTableCell", for: indexPath) as? ExplorListTableCell else {fatalError("identifiernya salah anying")}
            
            if allWbkl.count == 0 {
                fatalError("kosong tapi tampil")
            }
            
            let wbkl = allWbkl[indexPath.row - 1].wbklData
            
            if let currentLocation = (viewModel?.userLocation?.last) {
                let distance = viewModel?.getLocationDistance(userLocation: currentLocation, wbklData: wbkl)
                cell.wbklCategoryLabel.text = (wbkl.wbkl_type ?? "error ieu") + " · \(distance!) km"
                if distance! < 5815 {
                    cell.nearMarker.backgroundColor = .green
                } else {
                    cell.nearMarker.backgroundColor = .clear
                }
            } else {
                cell.wbklCategoryLabel.text = (wbkl.wbkl_type ?? "error ieu")
                cell.nearMarker.backgroundColor = .clear
            }
            cell.wbklNameLabel.text = wbkl.name
            
            
            if CommonFunction.shared.bukaTutupChecker(operationalDay: wbkl.operational_day ?? "Senin", operationalHour: wbkl.operational_hour ?? "10.00") == true {
                cell.wbklOperationalLabel.text = "Buka" + " · " + (wbkl.operational_hour ?? " ")
                cell.wbklOperationalLabel.textColor = .green
            } else {
                cell.wbklOperationalLabel.text = "Tutup"
                cell.wbklOperationalLabel.textColor = .red
            }
            
            var categories = allWbkl[indexPath.row - 1].categories
            
            if (viewModel?.categoriesChecker(wbkl: allWbkl[indexPath.row - 1], word: "karung goni"))! {
                let text = "karung goni"
                if let index = categories.firstIndex(of: text.capitalized) {
                    categories = viewModel?.rearrangeArray(array: categories, fromIndex: index, toIndex: categories.count-1 ) ?? ["mantan"]
                }
              
            }
            
            var putihputih = [cell.wbklSampahKategori1, cell.wbklSampahKategori2, cell.wbklSampahKategori3, cell.wbklSampahKategori4]
            let textPutihPutih = [cell.wbklSampahKateogri1Label, cell.wbklSampahKategori2Label, cell.wbklSampahKategori3Label, cell.wbklSampahKategori4Label]
            
            for putih in putihputih {
                putih?.alpha = 1
            }
            
            
            for int in 0..<categories.count {
                if int < 3 {
                    textPutihPutih[int]?.text = categories[int]
                } else {
                    textPutihPutih[3]?.text = "+\(categories.count-3)"
                }
            }
            
            for int in 0..<categories.count where int < 4 {
                putihputih.remove(at: 0)
            }
            
            for putih in putihputih {
                putih?.alpha = 0
            }
            cell.selectionStyle = .none
            return cell
        }
    }
}
// MARK: - TableView Delegate
extension EksplorListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row != 0 {
            let controller = EksplorDetailController.instantiateStoryboard(
                viewModel: EksplorDetailViewModel(wbklData: allWbkl[indexPath.row - 1].wbklData)
            )
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}


// MARK: - CLLocationManagerDelegate
extension EksplorListController: CLLocationManagerDelegate {
    
    func setupLocationManager() {
        viewModel?.locationManager.delegate = self
        viewModel?.locationManager.requestWhenInUseAuthorization()
        viewModel?.locationManager.requestLocation()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Got location data")
        viewModel?.userLocation = locations
        allWbkl = viewModel?.turnWbklsPro() ?? []
//            loadingView.hide()
            tableViewOutlet.reloadData()
//            for wbkl in allWbkl {
//                print(wbkl.wbklData.wasteAccepted)
//                print("-----------------------------------------------")
//                print(wbkl.wbklData.wasteCategory)
//            }
        
    }
}
