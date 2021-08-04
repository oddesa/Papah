//
//  TantanganListController.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

class TantanganListController: MVVMViewController<TantanganListViewModel> {

    @IBOutlet weak var tableView: UITableView!
    private let sectionLevel = 0
    private let sectionMonthly = 1
    private let sectionRewards = 2

    static let footerHeight = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel = TantanganListViewModel()

        registerNib()
    }

}


extension TantanganListController: UITableViewDelegate, UITableViewDataSource {
    
    func registerNib() {
        tableView.register(UINib(nibName: TantanganLevelTableCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: TantanganLevelTableCell.cellIdentifier())
        tableView.register(UINib(nibName: TantanganEarningCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: TantanganEarningCell.cellIdentifier())
        tableView.register(UINib(nibName: TantanganMonthlyCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: TantanganMonthlyCell.cellIdentifier())
        tableView.register(UINib(nibName: TantanganRewardTablecell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: TantanganRewardTablecell.cellIdentifier())
        tableView.register(UINib(nibName: "TantanganMonthlyHeadCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "TantanganMonthlyHeadCell")
        tableView.register(UINib(nibName: "TantanganRewardHeadCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "TantanganRewardHeadCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return [sectionLevel, sectionMonthly, sectionRewards].count
    }
    
    func tableviewIdentifier(section: Int) -> [String] {
        var identifiers = [String]()
        
        if section == sectionLevel {
            identifiers.append(TantanganLevelTableCell.cellIdentifier())
            identifiers.append(TantanganEarningCell.cellIdentifier())
        }
        if section == sectionMonthly {
            if let monthlyChallengeData = self.viewModel?.getMonthlyChallenge() {
                for _ in monthlyChallengeData {
                    identifiers.append(TantanganMonthlyCell.cellIdentifier())
                }
            }
        }
        if section == sectionRewards {
            identifiers.append(TantanganRewardTablecell.cellIdentifier())
        }
        
        return identifiers
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == sectionRewards {
            return 190
        }
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == sectionMonthly {
            return 45
        }
        if section == sectionRewards {
            return 45
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == sectionMonthly {
            
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TantanganMonthlyHeadCell") as? TantanganMonthlyHeadCell else {
                return UIView()
            }
            let backgroundView = UIView(frame: headerView.bounds)
            backgroundView.backgroundColor = .clear
            headerView.backgroundView = backgroundView

            return headerView
        }
        
        if section == sectionRewards {
            
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TantanganRewardHeadCell") as? TantanganRewardHeadCell else {
                return UIView()
            }
            let backgroundView = UIView(frame: headerView.bounds)
            backgroundView.backgroundColor = .clear
            headerView.backgroundView = backgroundView
            
            //navigasi
//            headerView.tmpilkanOutlet as! UIButton
            
            headerView.onDidSelectItem = { () in
                self.navigationController?.pushViewController(MedaliListController.instantiateStoryboard(viewModel: MedaliListViewModel(dummy: 4)), animated: true)
            }

            return headerView
        }
        
        return UIView()
     
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
        case TantanganLevelTableCell.cellIdentifier():
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TantanganLevelTableCell.cellIdentifier()) as? TantanganLevelTableCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            
            cell.updateDataView(userData: self.viewModel?.getUserData())
            
            return cell
        case TantanganEarningCell.cellIdentifier():
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TantanganEarningCell.cellIdentifier()) as? TantanganEarningCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            
            cell.updateDataView(userData: self.viewModel?.getUserData())
            
            return cell
        case TantanganMonthlyCell.cellIdentifier():
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TantanganMonthlyCell.cellIdentifier()) as? TantanganMonthlyCell else {
                return UITableViewCell()
            }
          
            cell.selectionStyle = .none
            
            cell.updateDataView(
                mcData: self.viewModel?.getMonthlyChallenge()?[indexPath.row],
                mcProgress: self.viewModel?.getMonthlyChallengeProgress()?[indexPath.row])
            
            return cell
        case TantanganRewardTablecell.cellIdentifier():
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TantanganRewardTablecell.cellIdentifier()) as? TantanganRewardTablecell else {
                return UITableViewCell()
                }
            //buatnavigasi lewat collectionCell
            cell.onDidSelectItem = {(indexPath) in
                let mdData = MedaliDetailData(image: UIImage.whatsAppImage20210719At085013, title: "akhirnya bisa yolo", desc: "kunci dari ngoding adalah tidur apabila pusyang berkepanjangan")
                let mdDatas = [mdData]
                self.navigationController?.pushViewController(MedaliDetailController.instantiateStoryboard(viewModel: MedaliDetailViewModel(datasVM: mdDatas)), animated: true)

            }
            
            cell.setData()
          
            cell.selectionStyle = .none
            
            return cell
     
        default:
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let identifier = self.tableviewIdentifier(section: indexPath.section)[indexPath.row]
        if indexPath.section == sectionRewards {
            print ("yojo")
        }
        
        switch identifier {
        case TantanganLevelTableCell.cellIdentifier():
            print(TantanganLevelTableCell.cellIdentifier())
        case TantanganEarningCell.cellIdentifier():
            print(TantanganEarningCell.cellIdentifier())
        case TantanganMonthlyCell.cellIdentifier():
            let ttdcData = ChallengeDetail.getChallengeDetaileData()
            self.navigationController?.present(TantanganDetailController.instantiateStoryboard(viewModel: TantanganDetailViewModel(challengeDetailData: ttdcData)), animated: true, completion: nil)
        case TantanganRewardTablecell.cellIdentifier():
            print("berak")
        default:
            print("ieu kunaon")
        }
    }
}
