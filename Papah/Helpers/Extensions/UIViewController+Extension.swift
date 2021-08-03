//
//  UIView+Extension.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import Foundation
import UIKit


class LoadingView {
    
    let uiView          :   UIView
    let message         :   String
    let messageLabel    =   UILabel()

    let loadingSV       =   UIStackView()
    let loadingView     =   UIView()
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)

    init(uiView: UIView, message: String) {
        self.uiView     =   uiView
        self.message    =   message
        self.setup()
    }

    func setup(){
        let viewWidth   = uiView.bounds.width
        let viewHeight  = uiView.bounds.height

        // Configuring the message label
        messageLabel.text             = message
        messageLabel.textColor        = UIColor.darkGray
        messageLabel.textAlignment    = .center
        messageLabel.numberOfLines    = 3
        messageLabel.lineBreakMode    = .byWordWrapping

        // Creating stackView to center and align Label and Activity Indicator
        loadingSV.axis          = .vertical
        loadingSV.distribution  = .equalSpacing
        loadingSV.alignment     = .center
        loadingSV.addArrangedSubview(activityIndicator)
        loadingSV.addArrangedSubview(messageLabel)

        // Creating loadingView, this acts as a background for label and activityIndicator
        loadingView.frame           = uiView.frame
        loadingView.center          = uiView.center
        loadingView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3)
        loadingView.clipsToBounds   = true

        // Disabling auto constraints
        loadingSV.translatesAutoresizingMaskIntoConstraints = false

        // Adding subviews
        loadingView.addSubview(loadingSV)
        uiView.addSubview(loadingView)
        activityIndicator.startAnimating()

        // Views dictionary
        let views = [
            "loadingSV": loadingSV
        ]

        uiView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(viewWidth / 2)-[loadingSV(0)]-|", options: [], metrics: nil, views: views))
        uiView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-\(viewHeight / 2)-[loadingSV(0)]-|", options: [], metrics: nil, views: views))
    }

    // Call this method to show loadingView
    func show() {
        loadingView.isHidden = false
    }

    // Call this method to hide loadingView
    func hide(){
        loadingView.isHidden = true
    }

    // Call this method to check if loading view already exists
    func isHidden() -> Bool{
        if loadingView.isHidden == false{
            return false
        }
        else{
            return true
        }
    }
}


extension Notification.Name {
    static let didReceiveData = Notification.Name("didReceiveData")
    static let didReceiveDataEvaluation = Notification.Name("didReceiveDataEvaluation")
    static let didCompleteTask = Notification.Name("didCompleteTask")
    static let completedLengthyDownload = Notification.Name("completedLengthyDownload")
}

extension UINavigationController {
  open override var shouldAutorotate: Bool {
    return true
  }
    
  open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return topViewController?.supportedInterfaceOrientations ?? .allButUpsideDown
  }
}

extension UITabBarController {
  open override var shouldAutorotate: Bool {
      return true
  }
    
  open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return selectedViewController?.supportedInterfaceOrientations ?? .allButUpsideDown
  }
}

extension UIViewController {

    static func instantiateStoryboard<T>(viewModel: T) -> MVVMViewController<T> {
        let controller =  UIStoryboard(name: String(describing: Self.self).replacingOccurrences(of: "Controller", with: ""), bundle: Bundle.main).instantiateInitialViewController() as! MVVMViewController<T>
        controller.viewModel = viewModel
        return controller
    }
    
    func showAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)

        let cancelButton = UIAlertAction(title: "Close", style: .destructive, handler: nil)
        
        alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showSelectionAlertWithCompletion(title: String, msg: String, confirmMsg: String, cancelMsg: String, completionBlock: @escaping (Bool) -> Void) {
       
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: confirmMsg, style: .default, handler: { _ in
            
            completionBlock(true)
        })
        
        let cancelButton = UIAlertAction(title: cancelMsg, style: .default, handler: { _ in
            
            completionBlock(false)
            
        })
        
        alert.addAction(cancelButton)
        alert.addAction(okButton)

        self.present(alert, animated: true, completion: nil)
    }
}
