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
    var filteredData: [String] = []
    var allWbkl: [WbklJarak] = []
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    private var loadingView: LoadingView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarItem.isEnabled = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = EksplorListViewModel()
        
        loadingView = LoadingView(uiView: self.view, message: "")
        loadingView.show()
        
        setupLocationManager()
        setupSearchController()
        setupNib()
        
    }
}

    // MARK: - UISearchController
extension EksplorListController: UISearchResultsUpdating {
    
    func setupSearchController() {
        navigationItem.searchController = searchBarCont
        searchBarCont.searchResultsUpdater = self
        searchBarCont.obscuresBackgroundDuringPresentation = false
        searchBarCont.searchBar.setValue("Batalkan", forKey: "cancelButtonText")
        searchBarCont.searchBar.placeholder = "Agen Sampah"
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        guard var dataWbkl = viewModel?.turnWbklsJarak() else {return}
        if text.count == 0 {
            allWbkl = dataWbkl
        } else {
            let splited = text.components(separatedBy: " ")
            allWbkl = []
            for wbkl in dataWbkl {
                for word in splited {
                    if (wbkl.wbklData.name ?? "").lowercased().contains(word.lowercased()) {//|| wbkl.wbklData.categori.lowercased().contains(word.lowercased()) {
                            allWbkl.append(wbkl)
                        guard let idx = dataWbkl.firstIndex(where: { $0 === wbkl }) else {return}
                            dataWbkl.remove(at: idx)
                    }
                }
            }
        }
       
        tableViewOutlet.reloadData()
        //logic sorting
//        filteredData = filteredData.sorted()
//        var users = [
//            User(firstName: "Jemima", home: "Alabama"),
//            User(firstName: "Peter", home: "Bogor"),
//            User(firstName: "David", home: "AAA"),
//            User(firstName: "Kelly", home: "zebratown"),
//            User(firstName: "Isabella", home: "lololo")
//        ]
//
//        users.sort {
//            $0.firstName > $1.firstName
//        }
//
//        let sortedUsers = users.sorted {
//            $0.firstName < $1.firstName
//        }
//
//        users.sort {
//            $0.home < $1.home
//        }
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
            cell.selectionStyle = .none
            return cell
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExplorListTableCell", for: indexPath) as? ExplorListTableCell else {fatalError("identifiernya salah anying")}
            
            let wbkl = allWbkl[indexPath.row - 1].wbklData
            if let currentLocation = (viewModel?.userLocation?.last) {
                let distance = viewModel?.getLocationDistance(userLocation: currentLocation, wbklData: wbkl)
                cell.wbklCategoryLabel.text = (wbkl.wbkl_type ?? "error ieu") + " · \(distance!) km"
            }
            cell.wbklNameLabel.text = wbkl.name
            
            
            if viewModel?.bukaTutupChecker(operationalDay: wbkl.operational_day ?? "Senin", operationalHour: wbkl.operational_hour ?? "10.00") == true {
                cell.wbklOperationalLabel.text = "Buka" + " · " + (wbkl.operational_hour ?? " ")
                cell.wbklOperationalLabel.textColor = .green
            } else {
                cell.wbklOperationalLabel.text = "Tutup"
                cell.wbklOperationalLabel.textColor = .red
            }
            
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
            
            for int in 0..<categories.count where int < 4 {
                putihputih.remove(at: 0)
            }
            
            for putih in putihputih {
                putih?.removeFromSuperview()
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
        
        if let viewModel = viewModel {
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
        allWbkl = viewModel?.turnWbklsJarak() ?? []
        if loadingView.isHidden() == false {
            loadingView.hide()
            tableViewOutlet.reloadData()
            for wbkl in allWbkl {
                print(wbkl.wbklData.wasteAccepted)
                print("-----------------------------------------------")
                print(wbkl.wbklData.wasteCategory)
            }
        }
    }
}
