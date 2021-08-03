//
//  TipsDetailCollectionCell.swift
//  Papah
//
//  Created by Dhiky Aldwiansyah on 26/07/21.
//

import UIKit

class TipsDetailCollectionCell: UICollectionViewCell {

    @IBOutlet weak var tipsImage: UIImageView!
    @IBOutlet weak var tipsTitle: UILabel!
    @IBOutlet weak var tipsDesc: UITextView!
    
    func setTipsDetailByCategory(with tipsDetail: SampahDetail){
        tipImage.image = UIImage(data: tipsDetail.image ?? Data())
        tipTitle.text = tipsDetail.title
        tipDesc.text = tipsDetail.detail
    }
}
