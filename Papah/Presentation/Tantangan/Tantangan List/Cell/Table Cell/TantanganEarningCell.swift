//
//  TantanganEarningCell.swift
//  Papah
//
//  Created by Dhiky Aldwiansyah on 28/07/21.
//

import UIKit

class TantanganEarningCell: UITableViewCell {

    @IBOutlet weak var descForLevelUp: UILabel!
    @IBOutlet weak var moneyValue: UILabel!
    
    func updateDataView(userData: User?){
        if let user = userData {
            let userMoney = String(user.total_uang)
//            descForLevelUp.text = "" tanya wurie bessok
            moneyValue.text = "Rp. \(userMoney)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
