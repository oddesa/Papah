//
//  TantanganMonthlyHeadCell.swift
//  Papah
//
//  Created by Dhiky Aldwiansyah on 28/07/21.
//

import UIKit

class TantanganMonthlyHeadCell: UITableViewHeaderFooterView {

    @IBOutlet weak var mcTitle: UILabel!
    
    func updateMonthlyTitle(currentMonth: Int){
            if currentMonth == 7 {
                mcTitle.text = "Tantangan Juli"
            } else {
                mcTitle.text = "Tantangan Agustus"
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
