//
//  EksplorDetailController.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit
import CoreLocation
import MapKit

class EksplorDetailController: MVVMViewController<EksplorDetailViewModel> {
    
    @IBOutlet weak var tableView: UITableView!
    
    let sectionDetail = 0
    let sectionWaste = 1
    let sectionEarning = 2
    
    static let footerHeight = 100
    var distanceLocation: Double = 0.0

    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNib()
        attemptLocationAccess()
        updateView()
    }
    
    func updateView(){
        self.title = self.viewModel?.wbklData?.name ?? ""
    }
    
    @IBAction func onClaimPoint(_ sender: Any) {
        
        let myAlert = CompletionAlert(nibName: CompletionAlert.id, bundle: nil)
        myAlert.delegate = self
        myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve

        self.tabBarController?.present(myAlert, animated: true, completion: nil)
        
    }
    
}

extension EksplorDetailController: CompletionAlertProtocol {
    func onConfirmButton() {
        
    }
}

extension EksplorDetailController: UITableViewDelegate, UITableViewDataSource {
    
    func registerNib() {
        tableView.register(UINib(nibName: EksplorDetailTableCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: EksplorDetailTableCell.cellIdentifier())
        tableView.register(UINib(nibName: EksplorDetailLimbarCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: EksplorDetailLimbarCell.cellIdentifier())
        tableView.register(UINib(nibName: EksplorDetailEarningCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: EksplorDetailEarningCell.cellIdentifier())
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return [sectionDetail, sectionWaste, sectionEarning].count
    }
    
    func tableviewIdentifier(section: Int) -> [String] {
        var identifiers = [String]()
        
        if section == sectionDetail {
            identifiers.append(EksplorDetailTableCell.cellIdentifier())
        }
        
        if section == sectionWaste {
            if let wasteAccData = self.viewModel?.getWasteAcceptedData() {
                for _ in wasteAccData {
                    identifiers.append(EksplorDetailLimbarCell.cellIdentifier())
                }
            }
        }
        
        if section == sectionEarning {
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
        if section == sectionEarning {
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
        
        if section == sectionWaste {
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
        return UIView()
    }
        
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
            
            cell.updateDataView(wbklData: self.viewModel?.wbklData)
            cell.updateDistance(distance: distanceLocation)
            
            cell.delegate = self
            
            return cell
        case EksplorDetailLimbarCell.cellIdentifier():
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EksplorDetailLimbarCell.cellIdentifier()) as? EksplorDetailLimbarCell else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            
            if let data = self.viewModel?.getWasteAcceptedData()?[indexPath.row] {
                cell.updateViewData(data: data, edtQuantity: self.viewModel?.singleEarningData[indexPath.row] ?? 0)
            }
            
            cell.textChanged { data in
                
                self.viewModel?.singleEarningData[indexPath.row] = Int(data) ?? 0

                DispatchQueue.main.async {
                    tableView.reloadSections(IndexSet(integer: self.sectionEarning), with: .none)
//                                                    tableView?.beginUpdates()
//                                                    tableView?.endUpdates()
                }
            }
            
            return cell
        case EksplorDetailEarningCell.cellIdentifier():
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EksplorDetailEarningCell.cellIdentifier()) as? EksplorDetailEarningCell else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            cell.updateEarning(totalEarnings: getTextFeildValuesFromTableView())
            
            return cell
        default:
            cell.selectionStyle = .none
            return cell
        }
    }
    
}

extension EksplorDetailController: EksplorDetailTableCellDelegate {
    
    func getTextFeildValuesFromTableView() -> Int {
        
        if let data = self.viewModel?.singleEarningData {
            
            var totalEarnings = 0
            
            print("TEXT datadatadata DATA \(data)")

            for earnings in data {
                totalEarnings += earnings
            }
            return totalEarnings

        }
        
        return 0
    }
    
    func openMaps() {
        if let wbklData = self.viewModel?.wbklData {
            let mapController = EksplorMapController.instantiateStoryboard(viewModel: EksplorMapViewModel(wbklData: wbklData))
            self.navigationController?.pushViewController(mapController, animated: true)
        }
    }
    
    func openPhoneCall() {
        guard let url = URL(string: "tel://0811111111"),
              UIApplication.shared.canOpenURL(url) else { return }
        if #available(iOS 10, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
}
