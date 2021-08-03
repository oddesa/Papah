//
//  TipsDetailCollectionCell.swift
//  Papah
//
//  Created by Dhiky Aldwiansyah on 26/07/21.
//

import UIKit

class TipsDetailCollectionCell: UICollectionViewCell {

    @IBOutlet weak var tipImage: UIImageView!
    @IBOutlet weak var tipTitle: UILabel!
    @IBOutlet weak var tipDesc: UILabel!
    
    func setTipsDetailByCategory(with tipsDetail: TipsDetail){
        tipTitle.text = tipsDetail.title
        tipDesc.text = tipsDetail.desc
    }

}
