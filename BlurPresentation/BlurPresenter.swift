//
//  BlurPresenter.swift
//  Insta360Nano
//
//  Created by 黄明 on 2016/11/3.
//  Copyright © 2016年 Insta360. All rights reserved.
//

import UIKit

class BlurPresenter: NSObject, UIViewControllerTransitioningDelegate {
    var blurStyle = UIBlurEffectStyle.dark {
        didSet {
            if let animationController = animationController {
                animationController.blurStyle = blurStyle
            }
        }
    }
    fileprivate var animationController: BlurPresentationController?
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        if animationController == nil {
            animationController = BlurPresentationController(presentedViewController: presented, presentingViewController: presenting, style: blurStyle)
            animationController?.didDismissHandler = { [unowned self] in
                self.animationController = nil 
            }
        }
        return animationController
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let transition = BlurTransitioning()
        transition.isPresentation = true
        
        return transition
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let transition = BlurTransitioning()
        transition.isPresentation = false
        
        return transition
    }
    
    
}
