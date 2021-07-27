//
//  EksplorListFilterController.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

struct FilterWaste {
    let id: String = UUID().uuidString
    let img: UIImage?
    let title: String?
    let isSelected: Bool?
    
    static func getFilterWasteData() -> [FilterWaste]{
        var fwData = [FilterWaste]()
        //let obImage = BagelsOnboardingImage()
        
        let fwData1 = FilterWaste(img: #imageLiteral(resourceName: "WhatsApp Image 2021-07-19 at 08.50.13"), title: "Elektronik", isSelected: false)
        let fwData2 = FilterWaste(img: #imageLiteral(resourceName: "WhatsApp Image 2021-07-19 at 08.50.13"), title: "Kardus", isSelected: false)
        let fwData3 = FilterWaste(img: #imageLiteral(resourceName: "WhatsApp Image 2021-07-19 at 08.50.13"), title: "Kertas", isSelected: false)
        let fwData4 = FilterWaste(img: #imageLiteral(resourceName: "WhatsApp Image 2021-07-19 at 08.50.13"), title: "Perabot", isSelected: false)
        let fwData5 = FilterWaste(img: #imageLiteral(resourceName: "WhatsApp Image 2021-07-19 at 08.50.13"), title: "Plastik", isSelected: false)
        
        fwData.append(fwData1)
        fwData.append(fwData2)
        fwData.append(fwData3)
        fwData.append(fwData4)
        fwData.append(fwData5)

        return fwData
    }
}

class EksplorListFilterController: UIViewController {
    
    @IBOutlet weak var wasteFilterTable: UITableView!
    
    private let viewModel = EksplorListFilterViewModel()
    
    var filterArr = [String]()
    var selectedFilter = [Int]()
    var filterData = [FilterWaste]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nibSetup()
        filterData = FilterWaste.getFilterWasteData()
        
        wasteFilterTable.dataSource = self
        wasteFilterTable.delegate = self
    }
}

extension EksplorListFilterController {
    func nibSetup() {
        let nib = UINib(nibName: "\(EksplorListFilterTableCell.self)", bundle: nil)
        wasteFilterTable.register(nib, forCellReuseIdentifier: "filterCell")
    }
}

extension EksplorListFilterController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for i in 0..<selectedFilter.count {
            if selectedFilter[i] != indexPath.row {
                selectedFilter.append(indexPath.row)
            } else {
                selectedFilter.remove(at: i)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }
    
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
        
        return cell
    }
}
