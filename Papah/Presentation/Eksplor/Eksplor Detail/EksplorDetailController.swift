//
//  EksplorDetailController.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit
import CoreLocation
import MapKit
import Combine

protocol EksplorDetailTableCellDelegate: AnyObject {
    func openMaps()
    func openPhoneCall()
    func openClaimButton()
    func openGps()
}

class EksplorDetailController: MVVMViewController<EksplorDetailViewModel> {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var trashBag = Set<AnyCancellable>()

    let sectionDetail = 0
    let sectionWaste = 1
    let sectionEarning = 2
    let sectionClaim = 3

    static let footerHeight = 100

    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .link
        navigationController?.navigationBar.prefersLargeTitles = true
        
        registerNib()
        setupView()
        setupViewModel()
        attemptLocationAccess()
    }
    
    func setupView(){
        self.title = self.viewModel?.wbkl?.wbklData.name ?? ""

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height/2
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func setupViewModel(){
        self.viewModel?.onRequirementCheck.sink(receiveValue: { requirementCheck in           
            self.tableView.reloadSections(IndexSet(integer: self.sectionClaim), with: .none)
        }).store(in: &trashBag)
        
    }
    
   
}

extension EksplorDetailController: CompletionAlertProtocol {
    func onConfirmButton() {
        self.tabBarController?.selectedIndex = 2
        self.navigationController?.popViewController(animated: false)
    }
}

extension EksplorDetailController: UITableViewDelegate, UITableViewDataSource {
    
    func registerNib() {
        tableView.register(UINib(nibName: EksplorDetailTableCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: EksplorDetailTableCell.cellIdentifier())
        tableView.register(UINib(nibName: EksplorDetailLimbarCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: EksplorDetailLimbarCell.cellIdentifier())
        tableView.register(UINib(nibName: EksplorDetailEarningCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: EksplorDetailEarningCell.cellIdentifier())
        tableView.register(UINib(nibName: EksplorDetailClaimTableCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: EksplorDetailClaimTableCell.cellIdentifier())
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return [sectionDetail, sectionWaste, sectionEarning, sectionClaim].count
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
            identifiers.append(EksplorDetailEarningCell.cellIdentifier())
        }
        
        if section == sectionEarning {
        }
        if section == sectionClaim {
            identifiers.append(EksplorDetailClaimTableCell.cellIdentifier())
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
        if section == sectionClaim {
            return 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == sectionWaste {
            return 45
        }
        if section == sectionClaim {
            return 45
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == sectionWaste {
            let headerFrame = tableView.frame
            
            let title = UILabel()
            title.frame =  CGRect(x: 16, y: 20, width: headerFrame.size.width-20, height: 20)
            title.font = title.font.withSize(14)
            title.text = "RINCIAN LIMBAH"
            title.textColor = .gray
            
            let headerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: headerFrame.size.width, height: headerFrame.size.height))
            headerView.addSubview(title)
            return headerView
        }
        if section == sectionClaim {
            let headerFrame = tableView.frame
            
            let title = UILabel()
            title.frame =  CGRect(x: 16, y: 20, width: headerFrame.size.width-20, height: 20)
            title.font = title.font.withSize(14)
            title.text = "KLAIM POIN"
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
            
            cell.updateDataView(wbklData: self.viewModel?.wbkl?.wbklData)
            cell.updateDistance(distance: self.viewModel?.distanceRouteMeter ?? 0)
            
            cell.delegate = self
            
            return cell
        case EksplorDetailLimbarCell.cellIdentifier():
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EksplorDetailLimbarCell.cellIdentifier()) as? EksplorDetailLimbarCell else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            
            if let data = self.viewModel?.getWasteAcceptedData()?[indexPath.row] {
                cell.updateViewData(data: data, edtQuantity: self.viewModel?.singleEarningData[indexPath.row].berat ?? 0)
            }
            
            cell.textChanged { data in
                
                self.viewModel?.singleEarningData[indexPath.row].berat = Float(data) ?? 0

                self.tableView.performBatchUpdates {
                    self.tableView.reloadRows(at: [IndexPath(row: (self.viewModel?.getWasteAcceptedData()?.count ?? 0), section: self.sectionWaste)], with: .none)
                    self.tableView.reloadRows(at: [IndexPath(row: 0, section: self.sectionClaim)], with: .none)
    //                self.tableView.reloadSections(IndexSet.init(integer: self.sectionClaim), with: .none)
                }

            }
            
            return cell
        case EksplorDetailEarningCell.cellIdentifier():
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EksplorDetailEarningCell.cellIdentifier()) as? EksplorDetailEarningCell else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            cell.updateEarning(totalEarnings: self.viewModel?.getEarningTotal() ?? 0)
            
            return cell
        case EksplorDetailClaimTableCell.cellIdentifier():
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EksplorDetailClaimTableCell.cellIdentifier()) as? EksplorDetailClaimTableCell else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            cell.delegate = self
            cell.updateClaimPointState(locationManager: self.locationManager, requirement: self.viewModel?.onRequirementCheck.value ?? EksplorDetailViewModel.RequirementCheck(hour: false, location: false, isOpen: false, category: false))
            
            return cell
        default:
            cell.selectionStyle = .none
            return cell
        }
    }
    
}

extension EksplorDetailController: EksplorDetailTableCellDelegate {
    func openClaimButton() {
        self.viewModel?.onPointClaimed()
        
        let myAlert = CompletionAlert(nibName: CompletionAlert.id, bundle: nil)
        myAlert.delegate = self
        myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve

        self.tabBarController?.present(myAlert, animated: true, completion: nil)
        
    }
    
    func openGps() {
        UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!)
    }
    
    func openMaps() {
        if let wbklData = self.viewModel?.wbkl?.wbklData {
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
