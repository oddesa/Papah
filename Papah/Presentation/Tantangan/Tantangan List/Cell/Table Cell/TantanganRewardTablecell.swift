//
//  TantanganRewardTablecell.swift
//  Papah
//
//  Created by Dhiky Aldwiansyah on 28/07/21.
//

import UIKit

class TantanganRewardTablecell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!

    var onDidSelectItem: ((IndexPath) -> ())?
    var badgeProgressData: [BadgeProgress] = []

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(badgeData: [BadgeProgress]?) {
        badgeProgressData = badgeData ?? []
        
        collectionView.reloadData()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: TantanganRewardCell.id, bundle: nil), forCellWithReuseIdentifier: TantanganRewardCell.id)

    }
    
  
}

extension TantanganRewardTablecell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

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
        return badgeProgressData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TantanganRewardCell", for: indexPath) as? TantanganRewardCell else {return UICollectionViewCell()}
        
        let currentValue = String(format: "%.0f", badgeProgressData[indexPath.row].current_value)
        let maxValue =  String(format: "%.0f",badgeProgressData[indexPath.row].badge?.max_value ?? 0)
        let imgAchieved = UIImage(data:badgeProgressData[indexPath.row].badge?.image_achieved ?? Data())
        let imgNotAchieved = UIImage(data:badgeProgressData[indexPath.row].badge?.image ?? Data())
        let img =  badgeProgressData[indexPath.row].status ?  imgAchieved : imgNotAchieved
        
        cell.montlyChallengenTitle.text = badgeProgressData[indexPath.row].badge?.title
        cell.monthlyChallengeDesc.text =  badgeProgressData[indexPath.row].status ? "Finished" : "\(currentValue) dari \(maxValue) selesai"
        cell.monthlyChallengeImg.image = img
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.onDidSelectItem?(indexPath)
    }
    
}
