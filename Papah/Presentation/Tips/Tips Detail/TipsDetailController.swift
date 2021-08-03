//
//  TipsDetailController.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

class TipsDetailController: MVVMViewController<TipsDetailViewModel>, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {        
        return self.viewModel?.getTipsDetail()?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tipsDetailCollection.dequeueReusableCell(withReuseIdentifier: "tipsDetailCell", for: indexPath) as! TipsDetailCollectionCell
        
        if let item = self.viewModel?.getTipsDetail(){
            cell.setTipsDetailByCategory(with: item[indexPath.row])
        }
        return cell
    }
    func collectionView(_ tableView: UITableView, widthForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func setTipsDetail(with tipsdetail: SampahDetail){
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tipsDetailCollection.delegate = self
        tipsDetailCollection.dataSource = self
        // Do any additional setup after loading the view.
                
    }
    @IBOutlet weak var tipsDetailCollection: UICollectionView!
}

extension TipsDetailController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 315, height: 654)
    }
}
