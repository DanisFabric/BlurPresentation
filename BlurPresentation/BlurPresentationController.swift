//
//  BlurPresentationController.swift
//  Insta360Nano
//
//  Created by 黄明 on 2016/11/3.
//  Copyright © 2016年 Insta360. All rights reserved.
//

import UIKit

class BlurPresentationController: UIPresentationController {
    var didDismissHandler: (() -> Void)?
    var blurStyle: UIBlurEffectStyle {
        didSet {
            let oldDimmingView = dimmingView
            
            dimmingView = UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
            dimmingView.frame = oldDimmingView.frame
            
            effectContainerView.insertSubview(dimmingView, aboveSubview: oldDimmingView)
            oldDimmingView.removeFromSuperview()
        }
    }
    
    fileprivate var dimmingView: UIVisualEffectView
    fileprivate let effectContainerView = UIView()
    
    init(presentedViewController: UIViewController, presentingViewController: UIViewController?, style: UIBlurEffectStyle) {
        blurStyle = style
        dimmingView = UIVisualEffectView(effect: UIBlurEffect(style: style))
        
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
}

extension BlurPresentationController {
    override func presentationTransitionWillBegin() {
        effectContainerView.frame = containerView!.bounds
        dimmingView.frame = containerView!.bounds
        
        effectContainerView.addSubview(dimmingView)
        containerView?.addSubview(effectContainerView)
        
        effectContainerView.alpha = 0
        
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { (_) in
                
                self.effectContainerView.alpha = 1.0
                
                }, completion: nil)
        }else {
            self.effectContainerView.alpha = 1.0
        }
    }
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            effectContainerView.alpha = 0
            
            return
        }
        coordinator.animate(alongsideTransition: { (_) in
            
            self.effectContainerView.alpha = 0
            
            }, completion: nil)
    }
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        guard completed else {
            return
        }
        didDismissHandler?()
    }
    override func containerViewWillLayoutSubviews() {
        effectContainerView.frame = containerView!.bounds
        dimmingView.frame = containerView!.bounds
        presentedViewController.view.frame = containerView!.bounds
    }
    override var shouldPresentInFullscreen : Bool {
        return true
    }
    override var adaptivePresentationStyle : UIModalPresentationStyle {
        return .custom
    }
}
