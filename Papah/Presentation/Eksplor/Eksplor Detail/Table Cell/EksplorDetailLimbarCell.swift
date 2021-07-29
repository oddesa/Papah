//
//  EksplorDetailLimbarCell.swift
//  Papah
//
//  Created by Dhiky Aldwiansyah on 28/07/21.
//

import UIKit

class EksplorDetailLimbarCell: UITableViewCell {
    
    @IBOutlet weak var viewTambah: DesignableView!
    @IBOutlet weak var edtQuantity: UITextField!
    
    @IBAction func onTapAdd(_ sender: Any) {
        viewTambah.isHidden = true
        edtQuantity.isHidden = false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
