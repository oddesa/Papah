//
//  EksplorDetailClaimTableCell.swift
//  Papah
//
//  Created by Dhiky Aldwiansyah on 23/08/21.
//

import UIKit
import CoreLocation

class EksplorDetailClaimTableCell: UITableViewCell {

    @IBOutlet weak var btnClaim: DesignableButton!
    
    @IBOutlet weak var lblRequirementLocation: UILabel!
    @IBOutlet weak var lblRequirementOpen: UILabel!
    @IBOutlet weak var lblRequirementHour: UILabel!
    @IBOutlet weak var lblRequirementCategory: UILabel!
    @IBOutlet weak var checkRequirementLocation: UIImageView!
    @IBOutlet weak var checkRequirementOpen: UIImageView!
    @IBOutlet weak var checkRequirementHour: UIImageView!
    @IBOutlet weak var checkRequirementCategory: UIImageView!

    @IBOutlet weak var viewRequirementLocation: UIView!
    @IBAction func onClaimBtn(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.lblRequirementOpen.text = L10n.claimPointRequirementOpen
        self.lblRequirementLocation.text = "\(L10n.claimPointRequirementLocation(Constants.claimPointDistance))"
        self.lblRequirementHour.text = L10n.claimPointRequirementHour(Constants.claimPointHours)
        self.lblRequirementCategory.text = L10n.claimPointRequirementCategory(Constants.claimPoinCategory)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateClaimPointState(locationManager: CLLocationManager, requirement: EksplorDetailViewModel.RequirementCheck){
        
        if requirement.category {
            self.checkRequirementCategory.tintColor = .systemGreen
            self.checkRequirementCategory.image = UIImage(systemName: "checkmark.circle.fill")
            self.lblRequirementCategory.textColor = .textPrimary
        } else {
            self.checkRequirementCategory.tintColor = .disabled
            self.lblRequirementCategory.textColor = .disabled
            self.checkRequirementCategory.image = UIImage(systemName: "x.circle")
        }
        
        if requirement.hour {
            self.checkRequirementHour.tintColor = .systemGreen
            self.lblRequirementHour.textColor = .textPrimary
            self.checkRequirementHour.image = UIImage(systemName: "checkmark.circle.fill")
            self.lblRequirementHour.text = L10n.claimPointRequirementHour(Constants.claimPointHours)
        } else {
            self.checkRequirementHour.tintColor = .disabled
            self.lblRequirementHour.textColor = .disabled
            self.checkRequirementHour.image = UIImage(systemName: "x.circle")
//            self.lblRequirementHour.text = "\(L10n.claimPointRequirementHour(Constants.claimPointHours)) (\(self.viewModel?.getHourLeftToClaimPoint() ?? ""))"
            self.lblRequirementHour.text = "\(L10n.claimPointRequirementHour(Constants.claimPointHours))"
        }

        if requirement.isOpen {
            self.checkRequirementOpen.tintColor = .systemGreen
            self.lblRequirementOpen.textColor = .textPrimary
            self.checkRequirementOpen.image = UIImage(systemName: "checkmark.circle.fill")
        } else {
            self.checkRequirementOpen.tintColor = .disabled
            self.lblRequirementOpen.textColor = .disabled
            self.checkRequirementOpen.image = UIImage(systemName: "x.circle")
        }
        
        if locationManager.authorizationStatus == .denied ||
            locationManager.authorizationStatus == .notDetermined ||
            locationManager.authorizationStatus == .restricted {
            self.checkRequirementLocation.tintColor = .disabled
            self.lblRequirementLocation.textColor = .disabled
            self.lblRequirementLocation.attributedText = "\(L10n.claimPointRequirementLocation(Constants.claimPointDistance)) (Nyalakan GPS)".withBoldText(text: "(Nyalakan GPS)", font: UIFont.systemFont(ofSize: 11), textBoldcolor: UIColor.systemBlue)
            self.viewRequirementLocation.isUserInteractionEnabled = true
            self.checkRequirementLocation.image = UIImage(systemName: "x.circle")
        } else {
            self.viewRequirementLocation.isUserInteractionEnabled = false
            self.lblRequirementLocation.text = "\(L10n.claimPointRequirementLocation(Constants.claimPointDistance))"
            if requirement.location {
                self.checkRequirementLocation.tintColor = .systemGreen
                self.lblRequirementLocation.textColor = .textPrimary
                self.checkRequirementCategory.image = UIImage(systemName: "checkmark.circle.fill")
            } else {
                self.checkRequirementLocation.tintColor = .disabled
                self.lblRequirementLocation.textColor = .disabled
                self.checkRequirementLocation.image = UIImage(systemName: "x.circle")
            }
        }
        
        if requirement.category && requirement.hour && requirement.isOpen && requirement.location  {
            self.btnClaim.backgroundColor = .link
            self.btnClaim.isUserInteractionEnabled = true
        } else {
            self.btnClaim.isUserInteractionEnabled = false
            self.btnClaim.backgroundColor = .disabled
        }
    }
    
}
