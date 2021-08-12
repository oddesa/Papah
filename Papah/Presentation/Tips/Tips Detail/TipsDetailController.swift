//
//  TipsDetailController.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

class TipsDetailController: MVVMViewController<TipsDetailViewModel>, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var tipsTitle : UILabel!
    @IBOutlet weak var tipsDesc : UILabel!
    @IBOutlet weak var pageControl : UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Variables asociated to collection view:
    fileprivate var currentPage: Int = 0
    fileprivate var pageSize: CGSize {
        let layout = self.collectionView?.collectionViewLayout as! UPCarouselFlowLayout
        var pageSize = layout.itemSize
        pageSize.width += layout.minimumLineSpacing
        return pageSize
    }
    
    fileprivate var colors: [UIColor] = [UIColor.black, UIColor.red, UIColor.green, UIColor.yellow]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        tabBarController?.tabBar.isHidden = true
        
        self.navigationController?.navigationBar.tintColor = .link
        
        self.addCollectionView()
        self.setupView()
        
    }
    
    func setupView(){
        onChangeTipsTitle()
        pageControl.numberOfPages = self.viewModel?.getTipsDetail()?.count ?? 0
    }
    
    func addCollectionView(){
        
        let pointEstimator = RelativeLayoutUtilityClass(referenceFrameSize: self.view.frame.size)
        
        let layout = UPCarouselFlowLayout()
        layout.itemSize = CGSize(width: pointEstimator.relativeWidth(multiplier: 0.85), height: self.collectionView.frame.height)
        layout.scrollDirection = .horizontal
        
        self.collectionView.collectionViewLayout = layout
        self.collectionView?.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.register(TipsDetailCollectionCell.self, forCellWithReuseIdentifier: "cellId")
        
        // Spacing between cells:
        let spacingLayout = self.collectionView?.collectionViewLayout as! UPCarouselFlowLayout
        spacingLayout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 10)
        
        self.view.addSubview(self.collectionView!)
    }
    
    // MARK: - Card Collection Delegate & DataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.getTipsDetail()?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! TipsDetailCollectionCell
        cell.customView.image = UIImage(data: (self.viewModel?.getTipsDetail()?[indexPath.row].image ?? UIImage.whatsAppImage20210719At085013.jpegData(compressionQuality: 100)) ?? Data())
        cell.customView.contentMode = .scaleAspectFit
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.collectionView?.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
        self.pageControl.currentPage = currentPage
        onChangeTipsTitle()
    }
    
    func onChangeTipsTitle(){
        if let tipsTitle = self.viewModel?.getTipsDetail()?[currentPage].title, let tipsDetail = self.viewModel?.getTipsDetail()?[currentPage].detail {
            self.tipsTitle.text = tipsTitle
            self.tipsDesc.text = tipsDetail
        }
    }
}
