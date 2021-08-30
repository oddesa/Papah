//
//  EksplorDetailTableCell.swift
//  Papah
//
//  Created by Dhiky Aldwiansyah on 25/07/21.
//

import UIKit

class EksplorDetailTableCell: UITableViewCell {

    @IBOutlet weak var viewPhone: DesignableView!
    @IBOutlet weak var viewMap: DesignableView!
    
    @IBOutlet weak var lblOperationalHours: UILabel!
    @IBOutlet weak var lblOperationalDay: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var wbklImage: UIImageView!
    @IBOutlet weak var lblDistance: UILabel!
    
    weak var delegate: EksplorDetailTableCellDelegate?
    
    @objc func onPhoneCallTapped(_ sender: Any) {
        self.delegate?.openPhoneCall()
    }
    
    @objc func onMapTapped(_ sender: Any) {
        self.delegate?.openMaps()
    }
    
    func updateDataView(wbklData: Wbkl?){
        
        if let wbkl = wbklData {
            lblTitle.text = wbkl.name
            lblType.text = wbkl.wbkl_type
            lblAddress.text = wbkl.address
            lblOperationalDay.text = wbkl.operational_day
            lblOperationalHours.text = wbkl.operational_hour
            wbklImage.image = UIImage(data: wbkl.image ?? Data())
        }
        
    }
    
    func updateDistance(distance: Double) {
        print("HGGH \(distance) ")
        var distance = distance
        if distance >= 1000 {
            let distanceInKM = distance / 1000
            let distanceInKMRounded = distanceInKM.rounded()
            lblDistance.text = " · \(String.init(format: "%.0f", distanceInKMRounded))km"
        }
        else {
            distance = distance.rounded()
            
            if distance == 0 {
                lblDistance.text = ""
            } else {
                lblDistance.text = " · \(String.init(format: "%.0f", distance))m".replacingOccurrences(of: "0.", with: "")
            }
        }
        
//        if distance == 0 {
//            lblDistance.text = ""
//        } else if distance < 1000  {
//            lblDistance.text = "· \(String.init(format: "%.0f", distance))m".replacingOccurrences(of: "0.", with: "")
//        } else {
//            lblDistance.text = "· \(String.init(format: "%.0f", distance))km"
//        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewMap.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onMapTapped(_:))))
        viewPhone.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onPhoneCallTapped(_:))))

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
