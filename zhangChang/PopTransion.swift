//
//  PopTransion.swift
//  zhangChang
//
//  Created by idea on 2017/12/16.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit

class PopTransion: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
         return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! AViewController
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! ViewController
        let container = transitionContext.containerView
        
        let snapshotView = fromVC.imgView.snapshotView(afterScreenUpdates: false)
        snapshotView?.frame = container.convert(fromVC.imgView.frame, from: fromVC.view)
        fromVC.imgView.isHidden = true
        
        toVC.view.frame = transitionContext.finalFrame(for: toVC)
        toVC.selectedCell.imgView.isHidden = true
        
        container.insertSubview(toVC.view, belowSubview: fromVC.view)
        container.addSubview(snapshotView!)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
            snapshotView?.frame = container.convert(toVC.selectedCell.imgView.frame, from: toVC.selectedCell)
            fromVC.view.alpha = 0
        }) { (finish: Bool) -> Void in
            toVC.selectedCell.imgView.isHidden = false
            snapshotView?.removeFromSuperview()
            fromVC.imgView.isHidden = false
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
