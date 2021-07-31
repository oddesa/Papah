//
//  EksplorListFilterCollectionTableCell.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 31/07/21.
//

import UIKit

class EksplorListFilterCollectionTableCell: UITableViewCell {

    @IBOutlet weak var collectionViewOtl: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
 // MARK: - CollectionView Configuration
extension EksplorListFilterCollectionTableCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setupCollectionView() {
        let nibColl = UINib(nibName: "EksplorListCollectionCell", bundle: nil)
        collectionViewOtl.register(nibColl, forCellWithReuseIdentifier: "EksplorListCollectionCell")
        
        collectionViewOtl.delegate = self
        collectionViewOtl.dataSource = self
        
        collectionViewOtl.showsHorizontalScrollIndicator = false
        
        collectionViewOtl.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EksplorListCollectionCell", for: indexPath) as? EksplorListCollectionCell else {
            fatalError("salah identifier si collection")
        }
        
        if indexPath.row == 1 {

            cell.categoryLabel.text = "yadyadyaydaydya"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? EksplorListCollectionCell else {fatalError("cugs")}
        
        if cell.categoryBubble.backgroundColor == .red {
            cell.categoryBubble.backgroundColor = .clear
        } else {
            cell.categoryBubble.backgroundColor = .red
        }
        
        
    }
}
