//
//  EksplorListCollectionCell.swift
//  Papah
//
//  Created by Dhiky Aldwiansyah on 25/07/21.
//

import UIKit

class EksplorListCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryBubble: DesignableView!
    @IBOutlet weak var categoryLabel: UILabel!
    //apakah button masih perlu?? nnti harusnya cukup dengan ngeklik si collection cell aja udah activate deactivate filter
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var isActive: Bool = false {
        didSet {
            setupCellView()
        }
    }
    
    private func setupCellView () {
        if isActive == true {
            categoryBubble.backgroundColor = .white
            categoryLabel.textColor = .iconIolite
        } else {
            categoryBubble.backgroundColor = .black
            categoryLabel.textColor = .white
        }
        
    }
    
    
    
    
    
    
}
