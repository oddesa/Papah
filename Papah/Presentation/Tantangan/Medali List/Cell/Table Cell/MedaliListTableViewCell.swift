//
//  MedaliListTableViewCell.swift
//  Papah
//
//  Created by Rizqi Ahmad Kurniawan on 28/07/21.
//

import UIKit

class MedaliListTableViewCell: UITableViewCell {

    static let identifier = "MedaliListTableViewCell"
    var tableIndex = 0
    var badgeProgressData: [BadgeProgress] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var onDidSelectItem: ((IndexPath) -> ())?
    
    func setData(bpData: [BadgeProgress]?, tableIndex: Int) {
        badgeProgressData = bpData ?? []
        
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
        var yourHeight = collectionView.bounds.height
        
        if badgeProgressData[indexPath.row].badge?.badge_category_id != 4 {
            yourHeight = collectionView.bounds.height/4.0
        } else {
            yourHeight = collectionView.bounds.height
        }
        
        
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
        return badgeProgressData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
       guard let cell =
            collectionView
            .dequeueReusableCell(withReuseIdentifier:
            "MedaliListCollectionViewCell", for: indexPath) as?
                MedaliListCollectionViewCell else {return UICollectionViewCell()}
        
        
        let currentValue = String(format: "%.0f", badgeProgressData[indexPath.row].current_value)
        let maxValue =  String(format: "%.0f",badgeProgressData[indexPath.row].badge?.max_value ?? 0)
        let desc = badgeProgressData[indexPath.row].status ? "Finished" : "\(currentValue) dari \(maxValue) selesai"
        
        cell.medalTitle.text = badgeProgressData[indexPath.row].badge?.title
        cell.medalDesc.text = desc
        cell.medalImg.image = badgeProgressData[indexPath.row].status ? UIImage(data: badgeProgressData[indexPath.row].badge?.image_achieved ?? Data()) :  UIImage(data:badgeProgressData[indexPath.row].badge?.image ?? Data())
        
            return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.onDidSelectItem?(indexPath)
    }
}
