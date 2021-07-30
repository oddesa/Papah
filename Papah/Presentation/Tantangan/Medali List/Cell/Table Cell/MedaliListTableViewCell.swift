//
//  MedaliListTableViewCell.swift
//  Papah
//
//  Created by Rizqi Ahmad Kurniawan on 28/07/21.
//

import UIKit

class MedaliListTableViewCell: UITableViewCell {

    static let identifier = "MedaliListTableViewCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    func setData() {
        collectionView.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: MedaliListCollectionViewCell.id, bundle: nil), forCellWithReuseIdentifier: MedaliListCollectionViewCell.id)
    }
}

extension MedaliListTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/3.0
        let yourHeight = collectionView.bounds.height
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell =
            collectionView
            .dequeueReusableCell(withReuseIdentifier:
            "MedaliListCollectionViewCell", for: indexPath) as!
            MedaliListCollectionViewCell
        
            return cell
    }
}
