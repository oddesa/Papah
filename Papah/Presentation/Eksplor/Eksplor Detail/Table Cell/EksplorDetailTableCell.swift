//
//  EksplorDetailTableCell.swift
//  Papah
//
//  Created by Dhiky Aldwiansyah on 25/07/21.
//

import UIKit

protocol EksplorDetailTableCellDelegate: AnyObject {
    func openMaps()
    func openPhoneCall()
}

class EksplorDetailTableCell: UITableViewCell {

    @IBOutlet weak var viewPhone: DesignableView!
    @IBOutlet weak var viewMap: DesignableView!
    
    @IBOutlet weak var lblOperationalHours: UILabel!
    @IBOutlet weak var lblOperationalDay: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    weak var delegate: EksplorDetailTableCellDelegate?
    
    @objc func onPhoneCallTapped(_ sender: Any) {
        self.delegate?.openPhoneCall()
    }
    
    @objc func onMapTapped(_ sender: Any) {
        self.delegate?.openMaps()
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
