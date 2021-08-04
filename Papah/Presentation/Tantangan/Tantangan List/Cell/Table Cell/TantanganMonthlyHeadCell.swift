//
//  TantanganMonthlyHeadCell.swift
//  Papah
//
//  Created by Dhiky Aldwiansyah on 28/07/21.
//

import UIKit

class TantanganMonthlyHeadCell: UITableViewHeaderFooterView {

    @IBOutlet weak var mcTitle: UILabel!
    
    func updateMonthlyTitle(mcData: MonthlyChallenge?){
        if let mc = mcData {
            if mc.month == 7 {
                mc.title = "Tantangan Juli"
            } else {
                mc.title = "Tantangan Agustus"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
