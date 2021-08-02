//
//  EksplorListCollectionCell.swift
//  Papah
//
//  Created by Dhiky Aldwiansyah on 25/07/21.
//

import UIKit

class EksplorListCollectionCell: UICollectionViewCell {
    
    
    @IBOutlet weak var categoryBtn: DesignableButton!
    
    @IBAction func categoryBtnPressed(_ sender: Any) {
        isActive = !isActive
    }
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
        
        setupCellView()
    }

    var isActive: Bool = false {
        didSet {
            setupCellView()
        }
    }
    
    private func setupCellView () {
        if isActive == true {
            categoryBtn.backgroundColor = .lightGray
            categoryBtn.borderColor = .iconIolite
            categoryBtn.tintColor = .iconIolite
            categoryBtn.setTitleColor(.iconIolite, for: .normal)
        } else {
            categoryBtn.backgroundColor = .white
            categoryBtn.borderColor = .black
            categoryBtn.tintColor = .black
            categoryBtn.setTitleColor(.black, for: .normal)

            
        }
        
    }
}
