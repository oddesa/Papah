//
//  TipsListTableCell.swift
//  Papah
//
//  Created by Dhiky Aldwiansyah on 25/07/21.
//

import UIKit

class TipsListTableCell: UITableViewCell {

    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    func setTips(with waste: Waste) {
        categoryLabel.text = waste.category
        descLabel.text = waste.desc
    }
}
