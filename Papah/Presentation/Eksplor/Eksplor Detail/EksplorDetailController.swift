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

class EksplorDetailController: MVVMViewController<EksplorDetailViewModel> {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnClaimPoint: DesignableButton!
    @IBOutlet weak var lblRequirementLocation: UILabel!
    @IBOutlet weak var lblRequirementOpen: UILabel!
    @IBOutlet weak var lblRequirementHour: UILabel!
    @IBOutlet weak var lblRequirementCategory: UILabel!
    @IBOutlet weak var checkRequirementLocation: UIImageView!
    @IBOutlet weak var checkRequirementOpen: UIImageView!
    @IBOutlet weak var checkRequirementHour: UIImageView!
    @IBOutlet weak var checkRequirementCategory: UIImageView!

    private var trashBag = Set<AnyCancellable>()

    let sectionDetail = 0
    let sectionWaste = 1
    let sectionEarning = 2
    
    static let footerHeight = 100
    var distanceLocation: Double = 0.0

    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .purpleTwo
        navigationController?.navigationBar.prefersLargeTitles = true
        registerNib()
        attemptLocationAccess()
        setupView()
        setupViewModel()
    }
    
    func setupView(){
        self.title = self.viewModel?.wbklData?.name ?? ""
        self.lblRequirementOpen.text = L10n.claimPointRequirementOpen
        self.lblRequirementLocation.text = "\(L10n.claimPointRequirementLocation(Constants.claimPointDistance))"
        self.lblRequirementHour.text = L10n.claimPointRequirementHour(Constants.claimPointHours)
        self.lblRequirementCategory.text = L10n.claimPointRequirementCategory(Constants.claimPoinCategory)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
 
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
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
    @IBAction func onClaimPoint(_ sender: Any) {
        
        self.viewModel?.onPointClaimed()
        
        let myAlert = CompletionAlert(nibName: CompletionAlert.id, bundle: nil)
        myAlert.delegate = self
        myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve

        self.tabBarController?.present(myAlert, animated: true, completion: nil)
        
    }
    
    func setupViewModel(){
        self.viewModel?.onRequirementCheck.sink(receiveValue: { requirementCheck in
           
            self.updateClaimPointState(requirement: requirementCheck)
            
        }).store(in: &trashBag)
        
    }
    
    func updateClaimPointState(requirement: EksplorDetailViewModel.RequirementCheck){
        
        if requirement.category {
            self.checkRequirementCategory.tintColor = .systemGreen
            self.lblRequirementCategory.textColor = .systemGreen
        } else {
            self.checkRequirementCategory.tintColor = .systemRed
            self.lblRequirementCategory.textColor = .systemRed
        }
        
        if requirement.hour {
            self.checkRequirementHour.tintColor = .systemGreen
            self.lblRequirementHour.textColor = .systemGreen
            self.lblRequirementHour.text = L10n.claimPointRequirementHour(Constants.claimPointHours)
        } else {
            self.checkRequirementHour.tintColor = .systemRed
            self.lblRequirementHour.textColor = .systemRed
            self.lblRequirementHour.text = "\(L10n.claimPointRequirementHour(Constants.claimPointHours)) (\(self.viewModel?.getHourLeftToClaimPoint() ?? ""))"
        }

        if requirement.isOpen {
            self.checkRequirementOpen.tintColor = .systemGreen
            self.lblRequirementOpen.textColor = .systemGreen
        } else {
            self.checkRequirementOpen.tintColor = .systemRed
            self.lblRequirementOpen.textColor = .systemRed
        }
        
        if locationManager.authorizationStatus == .denied ||
            locationManager.authorizationStatus == .notDetermined ||
            locationManager.authorizationStatus == .restricted {
            self.checkRequirementLocation.tintColor = .systemRed
            self.lblRequirementLocation.textColor = .systemRed
        } else {
            if requirement.location {
                self.checkRequirementLocation.tintColor = .systemGreen
                self.lblRequirementLocation.textColor = .systemGreen
            } else {
                self.checkRequirementLocation.tintColor = .systemRed
                self.lblRequirementLocation.textColor = .systemRed
            }
        }
        
        if requirement.category && requirement.hour && requirement.isOpen && requirement.location  {
            self.btnClaimPoint.backgroundColor = .purpleTwo
            self.btnClaimPoint.isUserInteractionEnabled = true
        } else {
            self.btnClaimPoint.isUserInteractionEnabled = false
            self.btnClaimPoint.backgroundColor = .disabled
        }
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
                cell.updateViewData(data: data, edtQuantity: self.viewModel?.singleEarningData[indexPath.row].berat ?? 0)
            }
            
            cell.textChanged { data in
                
                self.viewModel?.singleEarningData[indexPath.row].berat = Float(data) ?? 0

                DispatchQueue.main.async {
                    tableView.reloadSections(IndexSet(integer: self.sectionEarning), with: .none)
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
        default:
            cell.selectionStyle = .none
            return cell
        }
    }
    
}

extension EksplorDetailController: EksplorDetailTableCellDelegate {
    
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
