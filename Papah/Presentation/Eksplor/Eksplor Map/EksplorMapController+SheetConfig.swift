//
//  EksplorMapController.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

extension EksplorMapController {
    
    // MARK: - Configuration
    public struct BottomSheetConfiguration {
        let height: CGFloat
        let initialOffset: CGFloat
    }
    
    // MARK: - State
    public enum BottomSheetState {
        case initial
        case full
    }
    
    // MARK: - UI Setup
    public func setupBottomSheet() {
        configuration = BottomSheetConfiguration(height: UIScreen.main.bounds.height * 0.8,
                                                 initialOffset: UIScreen.main.bounds.height * 0.4 + self.view.safeAreaInsets.bottom)
        
        bottomSheetViewController.initBottomSheet(viewModel: viewModel, delegate: self, eksplorMapVC: self)
        
        self.addChild(bottomSheetViewController)
        
        self.view.addSubview(bottomSheetViewController.view)
        
        let panGesture = UIPanGestureRecognizer()
        panGesture.delegate = self
        panGesture.addTarget(self, action: #selector(handlePan))
        bottomSheetViewController.view.addGestureRecognizer(panGesture)
        
        bottomSheetViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.didMove(toParent: self)
        
        topConstraint = bottomSheetViewController.view.topAnchor
            .constraint(equalTo: self.view.bottomAnchor,
                        constant: -configuration.initialOffset)
        
        NSLayoutConstraint.activate([
            bottomSheetViewController.view.heightAnchor
                .constraint(equalToConstant: configuration.height),
            bottomSheetViewController.view.leftAnchor
                .constraint(equalTo: self.view.leftAnchor),
            bottomSheetViewController.view.rightAnchor
                .constraint(equalTo: self.view.rightAnchor),
            topConstraint
        ])
        
        bottomSheetViewController.didMove(toParent: self)
    }
    
    // MARK: - Bottom Sheet Actions
    public func showBottomSheet(animated: Bool = true) {
        self.topConstraint.constant = -configuration.height
        
        if animated {
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            }, completion: { _ in
                self.state = .full
            })
        } else {
            self.view.layoutIfNeeded()
            self.state = .full
        }
    }
    
    public func hideBottomSheet(animated: Bool = true) {
        self.topConstraint.constant = -configuration.initialOffset
        
        if animated {
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0.5,
                           options: [.curveEaseOut],
                           animations: {
                            self.view.layoutIfNeeded()
                           }, completion: { _ in
                            self.state = .initial
                           })
        } else {
            self.view.layoutIfNeeded()
            self.state = .initial
        }
    }
    
    // MARK: - Pan Action
    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: bottomSheetViewController.view)
        let velocity = sender.velocity(in: bottomSheetViewController.view)
        
        let yTranslationMagnitude = translation.y.magnitude
        
        switch sender.state {
        case .began, .changed:
            if self.state == .full {
                guard translation.y > 0 else { return }
                
                topConstraint.constant = -(configuration.height - yTranslationMagnitude)
                
                self.view.layoutIfNeeded()
            } else {
                let newConstant = -(configuration.initialOffset + yTranslationMagnitude)
                
                guard translation.y < 0 else { return }
                guard newConstant.magnitude < configuration.height else {
                    self.showBottomSheet()
                    return
                }
                
                topConstraint.constant = newConstant
                
                self.view.layoutIfNeeded()
            }
        case .ended:
            if self.state == .full {
                
                if yTranslationMagnitude >= configuration.height / 2 || velocity.y > 1000 {
                    self.hideBottomSheet()
                } else {
                    
                    self.showBottomSheet()
                }
            } else {
                
                if yTranslationMagnitude >= configuration.height / 2 || velocity.y < -1000 {

                    self.showBottomSheet()
                    
                } else {
                    self.hideBottomSheet()
                }
            }
        case .failed:
            if self.state == .full {
                self.showBottomSheet()
            } else {
                self.hideBottomSheet()
            }
        default: break
        }
    }
}
