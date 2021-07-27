//
//  CompletionAlert.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

protocol CompletionAlertProtocol {
    func onConfirmButton()
}

class CompletionAlert: UIViewController {

    var delegate: CompletionAlertProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        let blurFx = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurFxView = UIVisualEffectView(effect: blurFx)
        blurFxView.frame = view.bounds
        blurFxView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(blurFxView, at: 0)

    }
    
    @IBAction func onConfirmButton(_ sender: Any) {
        delegate.onConfirmButton()
    }
    
}
