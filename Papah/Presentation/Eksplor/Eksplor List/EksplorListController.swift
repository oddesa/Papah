//
//  EksplorListController.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

class EksplorListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    private let viewModel = EksplorListViewModel()
    let strings = ["asdfefsa", "hahahah", "xoxoxoox"]
    var filteredData: [String] = []
    
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        searchBarOutlet.delegate = self
//        tableViewOutlet.delegate = self
//        tableViewOutlet.dataSource = self
//        tableViewOutlet.rowHeight = UITableView.automaticDimension
//        tableViewOutlet.estimatedRowHeight = 200
//
        let nib = UINib(nibName: "ExplorListTableCell", bundle: nil)
        tableViewOutlet.register(nib, forCellReuseIdentifier: "ExplorListTableCell")
        
        filteredData = strings
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
        
        let categories = ["asfaf"]
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
    }

}

// MARK: - SearchBar
extension EksplorListController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        filteredData = []
        
        for string in strings {
            if string.uppercased().contains(searchText.uppercased()) {
                filteredData.append(string)
            }
        }
    
        self.tableViewOutlet.reloadData()
        
        
    }
}
