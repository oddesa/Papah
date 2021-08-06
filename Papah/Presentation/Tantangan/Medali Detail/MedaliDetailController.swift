//
//  MedaliDetailController.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

class MedaliDetailController: MVVMViewController<MedaliDetailViewModel>  {

    
    
    @IBOutlet weak var medaliTitle: UILabel!
    
    @IBOutlet weak var medaliDescription: UILabel!
    
    @IBOutlet weak var medaliImage: UIImageView!
    
    @IBAction func shareMedali( sender: UIBarButtonItem) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let badgeData = self.viewModel?.datas[0]
        
        medaliTitle.text = badgeData?.title
        medaliDescription.text = badgeData?.desc
        medaliImage.image = badgeData?.image
        
//        UIImageView.image = UIImage(named: "whatsapp")
//        UIImageView.backgroundColor = .red
//        UIImageView.ContentMode = .scaleAspectFill
//        UIImageView.layer.borderColor = .blue
    }

}
