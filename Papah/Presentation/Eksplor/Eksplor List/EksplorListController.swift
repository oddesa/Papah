//
//  EksplorListController.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

class DummyDataUhuy {
    let nama: String
    let categori: String
    init(nama: String, categori: String) {
        self.nama = nama
        self.categori = categori
    }
}


class EksplorListController: MVVMViewController<EksplorListViewModel> {
    
    let strings = ["asdfefsa", "hahahah", "xoxoxoox"]
    var searchBarCont = UISearchController()
    var filteredData: [String] = []
    var allWbkl: [Wbkl] = []
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = EksplorListViewModel()
        allWbkl = viewModel?.getWBklData() ?? []
//        var sortedAllWbkl = allWbkl.sort {
//            $0.name ?? "" < $1.name ?? ""
//        }
        
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
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        let splited = text.components(separatedBy: " ")
        
        let aaa = DummyDataUhuy(nama: "Ayam Pedes", categori: "Goreng")
        let a11 = DummyDataUhuy(nama: "Ayam Asin Rebus", categori: "Rebus")
        let bbb = DummyDataUhuy(nama: "Ayam Asin", categori: "Rebus")
        let ccc = DummyDataUhuy(nama: "Ayam Pahit", categori: "Bakar")
        let ddd = DummyDataUhuy(nama: "Ikan Duyung", categori: "Rebus")
        
        var dummyUntukDifilter = [aaa, a11, bbb, ccc, ddd]
        var filteredData: [String] = []
        
        
        for dummy in dummyUntukDifilter {
            for word in splited {
                if dummy.nama.lowercased().contains(word.lowercased()) || dummy.categori.lowercased().contains(word.lowercased()) {
                        filteredData.append(dummy.nama)
                        guard let idx = dummyUntukDifilter.firstIndex(where: { $0 === dummy }) else {return}
                        dummyUntukDifilter.remove(at: idx)
                }
            }
        }
        
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
            
            
            cell.wbklNameLabel.text = allWbkl[indexPath.row - 1].name
            cell.wbklCategoryLabel.text = allWbkl[indexPath.row - 1].wbkl_type
            cell.wbklOperationalLabel.text = (allWbkl[indexPath.row - 1].operational_day ?? " ") + " · " + (allWbkl[indexPath.row - 1].operational_hour ?? " ")
            
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
                viewModel: EksplorDetailViewModel(wbklData: allWbkl[indexPath.row - 1])
            )
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}


// MARK: - Kuburan
