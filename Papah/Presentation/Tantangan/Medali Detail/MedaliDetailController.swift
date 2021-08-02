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
        
//        UIImageView.image = UIImage(named: "whatsapp")
//        UIImageView.backgroundColor = .red
//        UIImageView.ContentMode = .scaleAspectFill
//        UIImageView.layer.borderColor = .blue

        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
