//
//  EksplorMapController.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

protocol EksplorMapBottomSheetDelegate: AnyObject {
    func showRoute()
    func updateInfo()
    func updateAddress(address: String)
}

class EksplorMapBottomSheet: UIViewController {
    
    weak var viewModel: EksplorMapViewModel?
    weak var eksplorMapVC: EksplorMapController?
    weak var delegate: EksplorMapDelegate?

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    @IBAction func btnRoute(_ sender: Any) {
        self.delegate?.beginRouteTracking()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer.cornerRadius = 20
        self.view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.view.layer.shadowColor = UIColor.black.cgColor
        self.view.layer.shadowOffset = .init(width: 0, height: -2)
        self.view.layer.shadowRadius = 20
        self.view.layer.shadowOpacity = 0.5
        
        // Do any additional setup after loading the view.
    }
    
    func initBottomSheet(viewModel: EksplorMapViewModel, delegate: EksplorMapDelegate, eksplorMapVC: EksplorMapController) {
        self.viewModel = viewModel
        self.delegate = delegate
        self.eksplorMapVC = eksplorMapVC
        self.eksplorMapVC?.delegate = self
    }

}

extension EksplorMapBottomSheet: EksplorMapBottomSheetDelegate {
    func showRoute() {
    }
    
    func updateInfo() {
        self.lblTitle.text = "Kang asep"
        self.lblDesc.text = "Kang dadang"
    }
    
    func updateAddress(address: String) {
        self.lblAddress.text = address
    }
    
    
}
