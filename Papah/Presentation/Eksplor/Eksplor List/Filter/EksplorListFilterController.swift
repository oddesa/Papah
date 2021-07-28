//
//  EksplorListFilterController.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

class EksplorListFilterController: UIViewController {
    
    @IBOutlet weak var wasteFilterTable: UITableView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    @IBAction func donePressed(_ sender: UIButton) {
        //send back filter data
    }
    
    @IBAction func resetPressed(_ sender: UIButton) {
        //reset all filter
        // swiftlint:disable identifier_name
        for i in 0..<filterData.count {
        // swiftlint:enable identifier_name
            if filterData[i].isSelected == true {
                filterData[i].isSelected = false
            }
        }
        wasteFilterTable.reloadData()
    }
    
    private let viewModel = EksplorListFilterViewModel()
    
    var filterArr = [String]()
    var selectedFilter = [Int]()
    var filterData = [FilterWaste]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nibSetup()
        tableViewSetup()
        
        filterData = FilterWaste.getFilterWasteData()
        
        wasteFilterTable.dataSource = self
        wasteFilterTable.delegate = self
    }
}

//MARK: Setup
extension EksplorListFilterController {
    func nibSetup() {
        let nib = UINib(nibName: "\(EksplorListFilterTableCell.self)", bundle: nil)
        wasteFilterTable.register(nib, forCellReuseIdentifier: "filterCell")
    }
    
    func tableViewSetup() {
        wasteFilterTable.layer.masksToBounds = true
        wasteFilterTable.backgroundColor = UIColor(red: 241.0 / 255.0, green: 242.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
        
        let header  = UIView(frame: CGRect(x: 0, y: 0, width: wasteFilterTable.frame.width, height: 0.5))
        header.backgroundColor = .separator
        wasteFilterTable.tableHeaderView = header
        wasteFilterTable.tableFooterView = UIView()
    }
}

//MARK: Tableview
extension EksplorListFilterController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell") as! EksplorListFilterTableCell
        
        let filter = filterData[indexPath.row]
        cell.wasteIcon.image = filter.img
        cell.wasteTitle.text = filter.title
        if filter.isSelected == false {
            cell.wasteChecklist.isHidden = true
        } else {
            cell.wasteChecklist.isHidden = false
        }
        
        cell.wasteIcon.contentMode = UIView.ContentMode.scaleAspectFill
        cell.wasteIcon.layer.masksToBounds = false
        cell.wasteIcon.clipsToBounds = true
        cell.wasteIcon.layer.cornerRadius = cell.wasteIcon.frame.size.width / 2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? EksplorListFilterTableCell else {
               return
           }
        
        if filterData[indexPath.row].isSelected == false {
            filterData[indexPath.row].isSelected = true
            cell.wasteChecklist.isHidden = false
        } else {
            filterData[indexPath.row].isSelected = false
            cell.wasteChecklist.isHidden = true
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }
}
