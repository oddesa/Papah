//
//  MedaliListCollectionViewCell.swift
//  Papah
//
//  Created by Rizqi Ahmad Kurniawan on 28/07/21.
//

import UIKit

class MedaliListCollectionViewCell: UICollectionViewCell {

    static let identifier = "MedaliListCollectionViewCell"
    
    @IBOutlet weak var medaliDetail: UIButton!
    @IBOutlet weak var medalTitle: UILabel!
    @IBOutlet weak var medalDesc: UILabel!
    @IBOutlet weak var medalImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
