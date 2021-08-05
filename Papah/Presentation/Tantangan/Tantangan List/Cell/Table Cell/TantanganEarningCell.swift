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
            let userMoney = Int(user.total_uang).currencyFormatter()
            descForLevelUp.text = "Kumpulkan 500 poin lagi untuk naik level"
            moneyValue.text = "\(userMoney)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
