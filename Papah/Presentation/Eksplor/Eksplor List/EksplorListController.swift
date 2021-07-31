//
//  EksplorListController.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

class EksplorListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let strings = ["asdfefsa", "hahahah", "xoxoxoox"]
    var searchBarCont = UISearchController()
    var filteredData: [String] = []
    var filterStrings: [String] = []
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    @IBOutlet weak var filterUtama: DesignableView!
    @IBOutlet weak var filterUtamaLabel: UILabel!
    
    @IBOutlet weak var filter1: DesignableView!
    @IBOutlet weak var filter1Label: UILabel!
    @IBOutlet weak var filter1Button: UIButton!
    
    @IBOutlet weak var filter2: DesignableView!
    @IBOutlet weak var filter2Label: UILabel!
    @IBOutlet weak var filter2Button: UIButton!
    
    @IBOutlet weak var filter3: DesignableView!
    @IBOutlet weak var filter3Label: UILabel!
    @IBOutlet weak var filter3Button: UIButton!
    
    private var viewModel: EksplorListViewModel?
    
    init(viewModel: EksplorListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "ExplorListTableCell", bundle: nil)
        tableViewOutlet.register(nib, forCellReuseIdentifier: "ExplorListTableCell")

        filteredData = strings
        filterStrings = ["asdas", "asdasda"] // "asdasd"]
        
        navigationItem.searchController = searchBarCont
        self.searchBarCont.searchBar.setValue("Batalkan", forKey: "cancelButtonText")

        setupFilter()
    }
    
    func setupFilter() {
        var filterViews = [filter1, filter2, filter3]
        var filterLabels = [filter1Label, filter2Label, filter3Label]
        var filterButtons = [filter1Button, filter2Button, filter3Button]
        
        if filterStrings.count != 0 {
            filterUtama.borderWidth = 1
            filterUtama.backgroundColor = filter1.backgroundColor
            filterUtama.borderColor = .iconIolite
            filterUtamaLabel.textColor = .iconIolite
            filterUtamaLabel.text = "Yahud"
        } else {
            filterUtama.borderColor = .disabled
            filterUtamaLabel.textColor = .black
            filterUtamaLabel.text = "Yahud"
        }
        
        for int in 0..<filterStrings.count {
            if int < 3 {
                filterLabels[int]?.text = filterStrings[int]
            }
//            else {
//                    filterLabels[3]?.text = "+\(categories.count-3)"
//            }
        }
        
        for fView in filterViews {
            fView?.alpha = 1
        }
        
        for int in 0..<filterStrings.count {
            if int < 3 {
                filterViews.remove(at: 0)
            }
        }
//
        for fView in filterViews {
            fView?.alpha = 0
        }
        
//        for fView in filterViews {
//            view.addSubview(fView!)
//        }
    }
    
    @IBAction func filter1CancelButton(_ sender: Any) {
        filterStrings.remove(at: 0)
        setupFilter()
    }
    
    @IBAction func filter2CancelButton(_ sender: Any) {
        filterStrings.remove(at: 1)
        setupFilter()
    }
    
    @IBAction func filter3CancelButton(_ sender: Any) {
        filterStrings.remove(at: 2)
        setupFilter()
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
