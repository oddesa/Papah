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
  
    // Note: must be strong
    @IBOutlet private var maxWidthConstraint: NSLayoutConstraint! {
        didSet {
            maxWidthConstraint.isActive = false
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
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
