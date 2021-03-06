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
        self.onDidSelectItem?()
    }
    var onDidSelectItem: (() -> ())?
    
//    var filterPassinganColCell = [WasteCategory]() {
//        didSet{
//            if
//        }
//    }
    
    
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
    
    func setupCellView () {
        if isActive == true {
            categoryBtn.backgroundColor = .link10
            categoryBtn.borderColor = .link60
            categoryBtn.borderWidth = 0.5
            categoryBtn.tintColor = .link
            categoryBtn.setTitleColor(.link, for: .normal)
        } else {
            categoryBtn.borderWidth = 0.5
            categoryBtn.backgroundColor = .backgroundPrimary
            categoryBtn.borderColor = .chevron
            categoryBtn.tintColor = .textPrimary
            categoryBtn.setTitleColor(.textPrimary, for: .normal)
        }
        
    }
}
