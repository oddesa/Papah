//
//  EksplorListController.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit
import CoreLocation
import Combine

protocol isAbleToReceiveData {
    func pass(categories: [WasteCategory])
}

class EksplorListController: MVVMViewController<EksplorListViewModel>, isAbleToReceiveData {
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    var searchBarCont = UISearchController()
    
    private var trashBag = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = EksplorListViewModel()
        setupSearchController()
        setupNib()
        setupViewModel()
        setupLocationManager()

        tableViewOutlet.separatorColor = .separator
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    @objc override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        searchBarCont.searchBar.endEditing(true)
    }
    
    
    func pass(categories: [WasteCategory]) {
        self.viewModel?.filterCategories = []
        for cat in categories {
            self.viewModel?.filterCategories.append(cat)
        }
        tableViewOutlet.reloadData()
    }
    
    func setupViewModel(){
        
        viewModel?.setupWbklProData()
       
        viewModel?.isItEmptyState.sink(receiveValue: { value in
            self.tableViewOutlet.reloadData()
        }).store(in: &trashBag)
        
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
        
        print("TESS")

        guard let text = searchController.searchBar.text else {
            return
        }
        if text.isEmpty {
            self.viewModel?.setupWbklProData()
            self.tableViewOutlet.reloadData()
        }
        
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        self.viewModel?.isItEmptyState.send(false)
        self.viewModel?.filterCategories = []
        self.tableViewOutlet.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel?.isItEmptyState.send(false)
        self.viewModel?.filterCategories = []
        self.tableViewOutlet.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        
        self.viewModel?.getWbklBasedOnSearch(text: text, filterCategories:  self.viewModel?.filterCategories ?? [])
        
        self.tableViewOutlet.reloadData()
    }
    
    
}

// MARK: - TableView DataSource
extension EksplorListController: UITableViewDataSource {
    
    func setupNib() {
        let nibTable = UINib(nibName: "ExplorListTableCell", bundle: nil)
        tableViewOutlet.register(nibTable, forCellReuseIdentifier: "ExplorListTableCell")
        let nibTable1 = UINib(nibName: "EksplorListFilterCollectionTableCell", bundle: nil)
        tableViewOutlet.register(nibTable1, forCellReuseIdentifier: "EksplorListFilterCollectionTableCell")
        let nibEmptyState = UINib(nibName: "EmptyStateTableCell", bundle: nil)
        tableViewOutlet.register(nibEmptyState, forCellReuseIdentifier: "EmptyStateTableCell")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel?.filteredWbkl.count == 0 {
            return 2
        } else {
            return (viewModel?.filteredWbkl.count ?? 0) + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //EksplorListFilterCollectionTableCell
        if indexPath.row == 0 && !(viewModel?.filteredWbkl.count == 0) {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EksplorListFilterCollectionTableCell", for: indexPath) as? EksplorListFilterCollectionTableCell else {fatalError("identifiernya salah anying")}
            
            cell.onDidSelectItem = { () in
                if let controller = EksplorListFilterController.instantiateStoryboard(viewModel: EksplorListFilterViewModel()) as? EksplorListFilterController {
                    controller.delegate = self
                    controller.viewModel = EksplorListFilterViewModel()
                    controller.viewModel?.dataPassingan =  self.viewModel?.filterCategories ?? []
                    self.navigationController?.present(controller, animated: true, completion: nil)
                }
                
            }
            
            cell.onDidSelectItemSecond = { (category) in
                
                if let filterCategories = self.viewModel?.filterCategories {
                    if !( filterCategories.contains(category.categoryData)) {
                        self.viewModel?.filterCategories.append(category.categoryData)
                    } else {
                        self.viewModel?.filterCategories =  filterCategories.filter {$0 != category.categoryData}
                    }
                    for cat in filterCategories {
                        print(cat.title ?? "Categori tak bernama")
                    }
                    self.viewModel?.wbklCategoryFiltered(withSearch: false)
                    self.tableViewOutlet.reloadData()
                }
                
            }
            
            cell.filterPassingan =  self.viewModel?.filterCategories ?? []
            
            if  self.viewModel?.filterCategories.count == 0 {
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
            tableView.separatorStyle = .singleLine
            return cell
            
        } else if viewModel?.isItEmptyState.value == true {
            
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "EksplorListFilterCollectionTableCell", for: indexPath) as? EksplorListFilterCollectionTableCell else {fatalError("identifiernya salah anying")}
                
                cell.onDidSelectItem = { () in
                    if let controller = EksplorListFilterController.instantiateStoryboard(viewModel: EksplorListFilterViewModel()) as? EksplorListFilterController {
                        controller.delegate = self
                        controller.viewModel = EksplorListFilterViewModel()
                        controller.viewModel?.dataPassingan = self.viewModel?.filterCategories ?? []
                        self.navigationController?.present(controller, animated: true, completion: nil)
                    }
                    
                }
                
                cell.onDidSelectItemSecond = { (category) in
                    if let filterCategories = self.viewModel?.filterCategories {
                        if !( filterCategories.contains(category.categoryData)) {
                            self.viewModel?.filterCategories.append(category.categoryData)
                        } else {
                            self.viewModel?.filterCategories =  filterCategories.filter {$0 != category.categoryData}
                        }
                        for cat in filterCategories {
                            print(cat.title ?? "Categori tak bernama")
                        }
                        self.viewModel?.wbklCategoryFiltered(withSearch: false)
                        self.tableViewOutlet.reloadData()
                    }
                    
                }
                
                cell.filterPassingan = self.viewModel?.filterCategories ?? []
                
                if self.viewModel?.filterCategories.count == 0 {
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
                tableView.separatorStyle = .singleLine
                return cell
            } else if indexPath.row == 1 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyStateTableCell", for: indexPath) as? EmptyStateTableCell else {fatalError("identifiernya salah anying")}
                tableView.separatorStyle = .none
                return cell
            } else {
                let cell = UITableViewCell()
                cell.backgroundColor = .backgroundPrimary
                cell.selectionStyle = .none
                tableView.separatorStyle = .none
                return cell
            }
            
            
            
        } else if !(viewModel?.filteredWbkl.count == 0) {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExplorListTableCell", for: indexPath) as? ExplorListTableCell else {fatalError("identifiernya salah anying")}
            
            if let data = viewModel?.filteredWbkl[indexPath.row - 1], let wbkl = viewModel?.filteredWbkl[indexPath.row - 1].wbklData {
                //                if let currentLocation = (viewModel?.userLocation?.last) {
                //                    viewModel?.getLocationDistance(wbklData: wbkl, userLocation: currentLocation) { jarakStr, jarakDbl in
                ////                        let distanceInString = viewModel?.locationDistanceString(distanceInMeter: distance ?? 1000)
                //                        cell.wbklCategoryLabel.text = (wbkl.wbkl_type ?? "error ieu") + " · \(jarakStr )"
                //                        if (jarakDbl ) < Constants.claimPointDistance && jarakDbl != 0 {
                //                            cell.nearMarker.isHidden = false
                //                        } else {
                //                            cell.nearMarker.isHidden = true
                //                        }
                //                    }
                //
                //                } else {
                //                    cell.wbklCategoryLabel.text = (wbkl.wbkl_type ?? "error ieu")
                //                    cell.nearMarker.isHidden = true
                //                }
                
                cell.wbklCategoryLabel.text = (wbkl.wbkl_type ?? "error ieu") + "\(data.getJarakInString())"
                if (data.jarak) < Constants.claimPointDistance && data.jarak != 0 {
                    cell.nearMarker.isHidden = false
                } else {
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
                
                guard var categories = viewModel?.filteredWbkl[indexPath.row - 1].categories,
                      let dataWbkl = (viewModel?.filteredWbkl[indexPath.row - 1]) else {
                    return UITableViewCell()}
                //
                //                guard let dataWbkl = (viewModel?.filteredWbkl[indexPath.row - 1]) else {return UITableViewCell()}
                
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
            tableView.separatorStyle = .singleLine
            return cell
            
        } else {
            let cell = UITableViewCell()
            cell.backgroundColor = .backgroundPrimary
            cell.selectionStyle = .none
            tableView.separatorStyle = .none
            return cell
        }
    }
}
// MARK: - TableView Delegate
extension EksplorListController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row != 0 {
            guard let wbkl = (viewModel?.filteredWbkl[indexPath.row - 1]) else {return}
            let controller = EksplorDetailController.instantiateStoryboard(
                viewModel: EksplorDetailViewModel(wbkl: wbkl))
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
        if searchBarCont.isActive == false {
            viewModel?.updateWbklDistance(completion: {
                self.tableViewOutlet.reloadData()
            })
        }
        
    }
}
