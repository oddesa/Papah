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
        return 2
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//        }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 0 {
//            return UITableView.automaticDimension
//        } else {
//            return 40
//        }
//    }
//
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 0 {
//            return UITableView.automaticDimension
//        } else {
//            return 40
//        }
//    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExplorListTableCell", for: indexPath) as? ExplorListTableCell else {fatalError("identifiernya salah anying")}
//        cell.textLabel?.text = filteredData[indexPath.row]
//        return tableView.dequeueReusableCell(withIdentifier: "ExplorListTableCell", for: indexPath)
        
        if indexPath.row == 0 {
            return tableView.dequeueReusableCell(withIdentifier: "1", for: indexPath)
        }
        
        if indexPath.row == 1 {
            return tableView.dequeueReusableCell(withIdentifier: "ExplorListTableCell", for: indexPath)
        }
        
        
        return UITableViewCell()
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
