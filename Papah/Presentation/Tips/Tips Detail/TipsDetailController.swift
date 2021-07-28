//
//  TipsDetailController.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

class TipsDetailController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tipsDetailDummy.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = tipsDetailDummy[indexPath.row]
        let cell = tipsDetailCollection.dequeueReusableCell(withReuseIdentifier: "tipsDetailCell", for: indexPath) as! TipsDetailCollectionCell
//        cell.item = surah
        cell.setTipsDetailByCategory(with: item)
        print("CELL \(cell)")
        return cell
    }
    
    private let tipsDetailDummy = [ TipsDetail(image: "yes", title: "Memilah Sampah Plastik", desc: "plastik lama terurai"), TipsDetail(image: "yes", title: "Menyalurkan Sampah Plastik", desc: "plastik lama terurai"), TipsDetail(image: "yes", title: "Merecycle plastic", desc: "plastik lama terurai")]
    
    private let viewModel = TipsDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tipsDetailCollection.delegate = self
        tipsDetailCollection.dataSource = self
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var tipsDetailCollection: UICollectionView!
}
struct TipsDetail{
    let image: String
    let title: String
    let desc: String
}
