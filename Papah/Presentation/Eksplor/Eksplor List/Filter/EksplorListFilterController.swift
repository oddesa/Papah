//
//  EksplorListFilterController.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit



class EksplorListFilterController: MVVMViewController<EksplorListFilterViewModel> {
    
    var delegate: isAbleToReceiveData?
    @IBOutlet weak var wasteFilterTable: UITableView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    @IBAction func donePressed(_ sender: UIButton) {
        delegate?.pass(categories: viewModel?.dataPassingan ?? [])
        self .dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetPressed(_ sender: UIButton) {
        // swiftlint:disable identifier_name
        viewModel?.dataPassingan.removeAll()
        viewModel?.resetFilterData()
        wasteFilterTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nibSetup()
        tableViewSetup()
        
        viewModel?.filterData = viewModel?.turnCategoriesPro() ?? []
        
        wasteFilterTable.dataSource = self
        wasteFilterTable.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        delegate?.pass(categories: viewModel?.dataPassingan ?? [])
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
        let header  = UIView(frame: CGRect(x: 0, y: 0, width: wasteFilterTable.frame.width, height: 0.5))
        header.backgroundColor = .separator
        wasteFilterTable.tableHeaderView = header
        wasteFilterTable.tableFooterView = UIView()
    }
}

//MARK: Tableview
extension EksplorListFilterController: UITableViewDataSource, UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell") as? EksplorListFilterTableCell else {return UITableViewCell()}
        
        if let filter = viewModel?.filterData[indexPath.row] {
            cell.wasteIcon.image = UIImage(data: filter.categoryData.image ?? Data())
            cell.wasteTitle.text = filter.categoryData.title
            if (viewModel?.dataPassingan.contains(filter.categoryData)) ?? false {
                cell.wasteChecklist.isHidden = false
            } else {
                cell.wasteChecklist.isHidden = true
            }
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
        if let category = viewModel?.filterData[indexPath.row]{
            if !(viewModel?.dataPassingan.contains(category.categoryData) ?? false) {
                category.isSelected = true
                cell.wasteChecklist.isHidden = false
                viewModel?.dataPassingan.append(category.categoryData)
            } else {
                category.isSelected = false
                cell.wasteChecklist.isHidden = true
                viewModel?.dataPassingan = viewModel?.dataPassingan.filter {$0 != category.categoryData} ?? []
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.filterData.count) ?? 0
    }
}
