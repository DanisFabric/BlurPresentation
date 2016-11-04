//
//  BlurTransitioning.swift
//  Insta360Nano
//
//  Created by 黄明 on 2016/11/3.
//  Copyright © 2016年 Insta360. All rights reserved.
//

import UIKit

class BlurTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    var isPresentation = false
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        let fromView = fromVC.view
        let toView = toVC.view
        
        let container = transitionContext.containerView
        
        if isPresentation {
            container.addSubview(toView!)
        }
        
        let animatingVC = isPresentation ? toVC : fromVC
        let animatingView = isPresentation ? toView : fromView
        
        let onScreenFrame = transitionContext.finalFrame(for: animatingVC)
        let offScreenFrame = onScreenFrame.offsetBy(dx: 0, dy: onScreenFrame.height)
        
        let initialFrame = isPresentation ? offScreenFrame : onScreenFrame
        let finalFrame = isPresentation ? onScreenFrame : offScreenFrame
        
        animatingView?.frame = initialFrame
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: UIViewAnimationOptions(), animations: { 
            
            animatingView?.frame = finalFrame
            
            }) { (completed) in
                if !self.isPresentation {
                    fromView?.removeFromSuperview()
                }
                transitionContext.completeTransition(true)
                
        }
    }
}
