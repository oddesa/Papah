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
        tipsImage.image = UIImage(data: (tipsDetail.image ?? UIImage.whatsAppImage20210719At085013.jpegData(compressionQuality: 1.0)) ?? Data())
        tipsTitle.text = tipsDetail.title
        tipsDesc.text = tipsDetail.detail
    }
}
