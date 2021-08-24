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
        guard let layout = self.collectionView?.collectionViewLayout as? UPCarouselFlowLayout else {
            return UPCarouselFlowLayout().itemSize
        }
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
        self.pageControlSelectionAction(pageControl)
        
    }
    
    func setupView(){
        pageControl.numberOfPages = self.viewModel?.getTipsDetail()?.count ?? 0
    }
    
    func addCollectionView(){
        
        let pointEstimator = RelativeLayoutUtilityClass(referenceFrameSize: self.collectionView.bounds.size)
        
        let layout = UPCarouselFlowLayout()
        layout.itemSize = CGSize(width: pointEstimator.relativeWidth(multiplier: 0.8), height: pointEstimator.relativeHeight(multiplier: 0.9))
        layout.scrollDirection = .horizontal
        
        self.collectionView.collectionViewLayout = layout
        self.collectionView?.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.register(TipsDetailCollectionCell.nib, forCellWithReuseIdentifier: "cellId")
        
        // Spacing between cells:
        guard let spacingLayout = self.collectionView?.collectionViewLayout as? UPCarouselFlowLayout else {return}
        spacingLayout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 10)
        self.view.addSubview(self.collectionView ?? self.view)
    }
    
    // MARK: - Card Collection Delegate & DataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.getTipsDetail()?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as? TipsDetailCollectionCell else {return UICollectionViewCell()}
        cell.imgView.image = UIImage(data: (self.viewModel?.getTipsDetail()?[indexPath.row].image ?? UIImage.whatsAppImage20210719At085013.jpegData(compressionQuality: 100)) ?? Data())
        cell.imgView.contentMode = .scaleAspectFit
        cell.lblTitle.text = self.viewModel?.getTipsDetail()?[indexPath.row].title ?? ""
        cell.lblDetail.text = self.viewModel?.getTipsDetail()?[indexPath.row].detail ?? ""
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let layout = self.collectionView?.collectionViewLayout as? UPCarouselFlowLayout else {return}
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
        self.pageControl.currentPage = currentPage
    }
    @IBAction func pageControlSelectionAction(_ sender: UIPageControl) {
        let page: Int? = sender.currentPage
        var frame: CGRect = self.collectionView.frame
        frame.origin.x = frame.size.width * CGFloat(page ?? 0)
        frame.origin.y = 0
        self.collectionView.scrollRectToVisible(frame, animated: true)
    }
}
