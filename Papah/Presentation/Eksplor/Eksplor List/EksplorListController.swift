//
//  EksplorListController.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit
import CoreLocation

protocol isAbleToReceiveData {
    func pass(categories: [WasteCategory])
}

class EksplorListController: MVVMViewController<EksplorListViewModel>, isAbleToReceiveData {
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    var searchBarCont = UISearchController()
    
    var filterCategories: [WasteCategory] = [] {
        didSet {
            viewModel?.returnWbklsBasedOnCat(filterCategories: filterCategories)
            tableViewOutlet.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = EksplorListViewModel()
        setupLocationManager()
        setupSearchController()
        setupNib()
        viewModel?.returnWbklsBasedOnCat(filterCategories: filterCategories)
        tableViewOutlet.separatorColor = .separator
        tableViewOutlet.reloadData()
    }
    
    func pass(categories: [WasteCategory]) {
        filterCategories = []
        for cat in categories {
            filterCategories.append(cat)
        }
        tableViewOutlet.reloadData()
    }
}

// MARK: - UISearchController
extension EksplorListController: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    
    func setupSearchController() {
        navigationItem.searchController = searchBarCont
        searchBarCont.searchResultsUpdater = self
        searchBarCont.delegate = self
        searchBarCont.searchBar.delegate = self
        searchBarCont.obscuresBackgroundDuringPresentation = false
        searchBarCont.searchBar.setValue("Batalkan", forKey: "cancelButtonText")
        searchBarCont.searchBar.placeholder = "Agen Sampah"
        searchBarCont.searchBar.tintColor = .link
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        //
    }
    func willPresentSearchController(_ searchController: UISearchController) {
        viewModel?.allWbkl = []
        tableViewOutlet.reloadData()
    }
    
    
    func willDismissSearchController(_ searchController: UISearchController) {
        filterCategories = []
        viewModel?.returnWbklsBasedOnCat(filterCategories: filterCategories)
        tableViewOutlet.reloadData()
    }
    func didDismissSearchController(_ searchController: UISearchController) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        guard var dataWbkl = viewModel?.turnWbklsPro() else {return}
        dataWbkl = (viewModel?.filterBasedOnCat(allWbkl: dataWbkl, filterCategories: filterCategories)) ?? []
        viewModel?.getWbklBasedOnSearch(text: text, dataWbkl: dataWbkl, filterCategories: filterCategories)
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
        return (viewModel?.allWbkl.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //EksplorListFilterCollectionTableCell
        if indexPath.row == 0 && !(viewModel?.allWbkl.count == 0) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EksplorListFilterCollectionTableCell", for: indexPath) as? EksplorListFilterCollectionTableCell else {fatalError("identifiernya salah anying")}
            
            cell.onDidSelectItem = { () in
                if let controller = EksplorListFilterController.instantiateStoryboard(viewModel: EksplorListFilterViewModel()) as? EksplorListFilterController {
                    
                    controller.delegate = self
                    controller.viewModel = EksplorListFilterViewModel()
                    controller.viewModel?.dataPassingan = self.filterCategories
                    self.navigationController?.present(controller, animated: true, completion: nil)
                }
                
            }
            
            cell.onDidSelectItemSecond = { (category) in
                if !(self.filterCategories.contains(category.categoryData)) {
                    self.filterCategories.append(category.categoryData)
                } else {
                    self.filterCategories = self.filterCategories.filter {$0 != category.categoryData}
                }
                for cat in self.filterCategories {
                    print(cat.title ?? "Categori tak bernama")
                }
            }
            
            cell.filterPassingan = self.filterCategories
            
            if filterCategories.count == 0 {
                cell.filterBtn.borderWidth = 0.5
                cell.filterBtn.backgroundColor = .backgroundPrimary
                cell.filterBtn.borderColor = .chevron
                cell.filterBtn.tintColor = .textPrimary
                cell.filterBtn.setTitleColor(.textPrimary, for: .normal)
            } else {
                cell.filterBtn.backgroundColor = .link10
                cell.filterBtn.borderColor = .link60
                cell.filterBtn.borderWidth = 0.5
                cell.filterBtn.tintColor = .link
                cell.filterBtn.setTitleColor(.link, for: .normal)
            }
            cell.backgroundColor = .backgroundPrimary
            cell.selectionStyle = .none
            return cell
            
        } else if !(viewModel?.allWbkl.count == 0) {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExplorListTableCell", for: indexPath) as? ExplorListTableCell else {fatalError("identifiernya salah anying")}
            
            //            if viewModel?.allWbkl.count == 0 {
            //                fatalError("kosong tapi tampil")
            //            }
            
            if let wbkl = viewModel?.allWbkl[indexPath.row - 1].wbklData {
                if let currentLocation = (viewModel?.userLocation?.last) {
                    let distance = viewModel?.getLocationDistance(userLocation: currentLocation, wbklData: wbkl)
                    let distanceInString = viewModel?.locationDistanceString(distanceInMeter: distance ?? 1000)
                    cell.wbklCategoryLabel.text = (wbkl.wbkl_type ?? "error ieu") + " · \(distanceInString ?? "")"
                    if (distance ?? 1000) < Constants.claimPointDistance {
                        cell.nearMarker.isHidden = false
                    } else {
                        cell.nearMarker.isHidden = true
                    }
                } else {
                    cell.wbklCategoryLabel.text = (wbkl.wbkl_type ?? "error ieu")
                    cell.nearMarker.isHidden = true
                }
                cell.wbklNameLabel.text = wbkl.name
                cell.wbklPhoto.image = UIImage(data: wbkl.image ?? Data())
                
                
                if CommonFunction.shared.bukaTutupChecker(operationalDay: wbkl.operational_day ?? "Senin", operationalHour: wbkl.operational_hour ?? "10.00") == true {
                    cell.wbklOperationalLabel.text = "Buka" + " · " + (wbkl.operational_hour ?? " ")
                    //                    cell.wbklOperationalLabel.textColor = .green
                    cell.wbklOperationalLabel.attributedText = "Buka · \(wbkl.operational_hour ?? " ")".withBoldText(text: "Buka", font: UIFont.systemFont(ofSize: 14), textBoldcolor: .link)
                } else {
                    cell.wbklOperationalLabel.text = "Tutup"
                    cell.wbklOperationalLabel.textColor = .gray
                }
                
                guard var categories = viewModel?.allWbkl[indexPath.row - 1].categories else {return UITableViewCell()}
                
                guard let dataWbkl = (viewModel?.allWbkl[indexPath.row - 1]) else {return UITableViewCell()}
                
                if (viewModel?.categoriesChecker(wbkl: dataWbkl, word: "karung goni")) ?? false {
                    let text = "karung goni"
                    if let index = categories.firstIndex(of: text.capitalized) {
                        categories = viewModel?.rearrangeArray(array: categories, fromIndex: index, toIndex: (categories.count)-1 ) ?? ["mantan"]
                    }
                }
                
                var putihputih = [cell.wbklSampahKategori1, cell.wbklSampahKategori2, cell.wbklSampahKategori3, cell.wbklSampahKategori4]
                let textPutihPutih = [cell.wbklSampahKateogri1Label, cell.wbklSampahKategori2Label, cell.wbklSampahKategori3Label, cell.wbklSampahKategori4Label]
                
                for putih in putihputih {
                    putih?.alpha = 1
                    putih?.backgroundColor = .buttonSmall
                }
                
                for int in 0..<categories.count {
                    if int < 3 {
                        textPutihPutih[int]?.text = categories[int]
                        textPutihPutih[int]?.textColor = .textPrimary
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
            }
            
            
            cell.backgroundColor = .backgroundPrimary
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = UITableViewCell()
            cell.backgroundColor = .backgroundPrimary
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
            guard let wbkl = (viewModel?.allWbkl[indexPath.row - 1].wbklData) else {return}
            let controller = EksplorDetailController.instantiateStoryboard(
                viewModel: EksplorDetailViewModel(wbklData: wbkl))
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
        viewModel?.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        viewModel?.locationManager.distanceFilter = kCLDistanceFilterNone
        viewModel?.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        viewModel?.userLocation = locations
        viewModel?.returnWbklsBasedOnCat(filterCategories: filterCategories)
        tableViewOutlet.reloadData()
    }
}
