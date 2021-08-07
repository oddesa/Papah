//
//  TipsDetailController.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

class TipsDetailController: MVVMViewController<TipsDetailViewModel>, UIScrollViewDelegate {
    @IBOutlet weak var tipsImageScrollView : UIScrollView!
    @IBOutlet weak var tipsTitle : UILabel!
    @IBOutlet weak var tipsDesc : UILabel!
    @IBOutlet weak var pageControl : UIPageControl!
    
    var scrollWidth: CGFloat! = 0.0
    var scrollHeight: CGFloat! = 0.0
    
    override func viewDidLayoutSubviews() {
        scrollWidth = tipsImageScrollView.frame.size
            .width
        scrollHeight = tipsImageScrollView.frame.size.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        tabBarController?.tabBar.isHidden = true

        self.navigationController?.navigationBar.tintColor = .purpleTwo
        self.tipsImageScrollView.delegate = self
        tipsImageScrollView.isPagingEnabled = true
        tipsImageScrollView.showsVerticalScrollIndicator = false
        tipsImageScrollView.showsHorizontalScrollIndicator = false
        

        if let imgs = self.viewModel?.getTipsDetail(){
            var frame = CGRect (x: 0, y: 0, width: 0, height: 0)

            for index in 0..<imgs.count {
                frame.origin.x = scrollWidth * CGFloat (index)
                frame.size = CGSize (width: scrollWidth, height: scrollHeight)

                let slide = UIView(frame: frame)

                //subview
                let imageView = UIImageView.init(image:UIImage.init(data:(imgs[index].image ?? UIImage.whatsAppImage20210719At085013.jpegData(compressionQuality: 100)) ?? Data()))
                imageView.frame = CGRect(x: 0, y:0, width: scrollWidth, height: scrollHeight - 100)
                imageView.contentMode = .scaleToFill
                
                imageView.layer.masksToBounds = false
                imageView.clipsToBounds = true
                imageView.layer.cornerRadius = 10

                slide.addSubview(imageView)
                tipsImageScrollView.addSubview(slide)
            }

            tipsImageScrollView.contentSize = CGSize(width: scrollWidth * CGFloat(imgs.count), height: scrollHeight)
            self.tipsImageScrollView.contentSize.height = 1.0

            pageControl.numberOfPages = imgs.count
            pageControl.currentPage = 0
            self.tipsTitle.text = imgs[0].title
            self.tipsDesc.text = imgs[0].detail
            self.title = self.viewModel?.tips?.title ?? ""
        }
        
    }
    
    func setIndicatorForCurrentPage()  {
        let page = (tipsImageScrollView?.contentOffset.x)!/scrollWidth
        pageControl?.currentPage = Int(page)
        self.tipsTitle.text = self.viewModel?.getTipsDetail()?[pageControl?.currentPage ?? 0].title
        self.tipsDesc.text = self.viewModel?.getTipsDetail()?[pageControl?.currentPage ?? 0].detail
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setIndicatorForCurrentPage()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        setIndicatorForCurrentPage()
    }
    
    @IBAction func pageChanged(_ sender: Any) {
        tipsImageScrollView!.scrollRectToVisible(CGRect(x: scrollWidth*CGFloat((pageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
        
    }
    
}
 
