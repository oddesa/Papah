//
//  EksplorDetailController.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

class EksplorDetailController: UIViewController {
    
    private let viewModel = EksplorDetailViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    private let sectionDetail = 0
    private let sectionWaste = 1

    static let footerHeight = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNib()
    }

}



extension EksplorDetailController: UITableViewDelegate, UITableViewDataSource {
    
    func registerNib() {
        tableView.register(UINib(nibName: EksplorDetailTableCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: EksplorDetailTableCell.cellIdentifier())
        tableView.register(UINib(nibName: EksplorDetailLimbarCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: EksplorDetailLimbarCell.cellIdentifier())
        tableView.register(UINib(nibName: EksplorDetailEarningCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: EksplorDetailEarningCell.cellIdentifier())
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return [sectionDetail, sectionWaste].count
    }
    
    func tableviewIdentifier(section: Int) -> [String] {
        var identifiers = [String]()
        
        if section == sectionDetail {
            identifiers.append(EksplorDetailTableCell.cellIdentifier())
        }
        if section == sectionWaste {
            identifiers.append(EksplorDetailLimbarCell.cellIdentifier())
            identifiers.append(EksplorDetailEarningCell.cellIdentifier())
        }
        return identifiers
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == sectionWaste {
            return 200
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == sectionWaste {
            return 45
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerFrame = tableView.frame
        
        let title = UILabel()
        title.frame =  CGRect(x: 16, y: 20, width: headerFrame.size.width-20, height: 20) //width equals to parent view with 10 left and right margin
        title.font = title.font.withSize(14)
        title.text = "RINCIAN LIMBAH"
//        title.text = self.tableView(tableView, titleForHeaderInSection: section) //This will take title of section from 'titleForHeaderInSection' method or you can write directly
        title.textColor = .gray
        
        let headerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: headerFrame.size.width, height: headerFrame.size.height))
        headerView.addSubview(title)
        
        return headerView
    }
    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return CGFloat(TantanganListController.footerHeight)
//    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableviewIdentifier(section: section).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = self.tableviewIdentifier(section: indexPath.section)[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) else {
            return UITableViewCell()
        }
        
        switch identifier {
        case EksplorDetailTableCell.cellIdentifier():
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EksplorDetailTableCell.cellIdentifier()) as? EksplorDetailTableCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            
            return cell
        case EksplorDetailLimbarCell.cellIdentifier():
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EksplorDetailLimbarCell.cellIdentifier()) as? EksplorDetailLimbarCell else {
                return UITableViewCell()
            }
          
            cell.selectionStyle = .none
            
            return cell
        case EksplorDetailEarningCell.cellIdentifier():
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EksplorDetailEarningCell.cellIdentifier()) as? EksplorDetailEarningCell else {
                return UITableViewCell()
            }
          
            cell.selectionStyle = .none
            
            return cell
        default:
            cell.selectionStyle = .none
            return cell
        }
    }
    
    
}
