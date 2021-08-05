//
//  CompletionAlert.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

protocol CompletionAlertProtocol: NSObject {
    func onConfirmButton()
}

class CompletionAlert: UIViewController {

    weak var delegate: CompletionAlertProtocol?

    @IBOutlet weak var lblPointClaim: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        let blurFx = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurFxView = UIVisualEffectView(effect: blurFx)
        blurFxView.frame = view.bounds
        blurFxView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(blurFxView, at: 0)
        
//        self.lblPointClaim.text = "Kamu berhasil mengklaim \(Constants) poin dari penyaluran limbah"

    }
    
    @IBAction func onConfirmButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        delegate?.onConfirmButton()
    }
    
}
