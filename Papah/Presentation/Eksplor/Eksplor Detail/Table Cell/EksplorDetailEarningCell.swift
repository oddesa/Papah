//
//  EksplorDetailEarningCell.swift
//  Papah
//
//  Created by Dhiky Aldwiansyah on 28/07/21.
//

import UIKit

class EksplorDetailEarningCell: UITableViewCell {

    @IBOutlet weak var lblPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateEarning(totalEarnings: Float) {
        self.lblPrice.text = "\(totalEarnings.currencyFormatter())"
    }
    
}
