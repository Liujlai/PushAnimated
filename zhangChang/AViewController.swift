//
//  AViewController.swift
//  zhangChang
//
//  Created by idea on 2017/12/16.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit

class AViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var imgView: UIImageView!
    var image: UIImage!
    
    private var percentDrivenTransition: UIPercentDrivenInteractiveTransition?
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.delegate = self
        
        //手势监听器
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action:#selector(AViewController.edgePanGesture(edgePan:)))
        edgePan.edges = UIRectEdge.left
        self.view.addGestureRecognizer(edgePan)
        
    }
    
    @objc func edgePanGesture(edgePan: UIScreenEdgePanGestureRecognizer) {
        let progress = edgePan.translation(in: self.view).x / self.view.bounds.width
        if edgePan.state == UIGestureRecognizerState.began {
            self.percentDrivenTransition = UIPercentDrivenInteractiveTransition()
            self.navigationController?.popViewController(animated: true)
        } else if edgePan.state == UIGestureRecognizerState.changed {
            self.percentDrivenTransition?.update(progress)
        } else if edgePan.state == UIGestureRecognizerState.cancelled || edgePan.state == UIGestureRecognizerState.ended {
            if progress > 0.5 {
                self.percentDrivenTransition?.finish()
            } else {
                self.percentDrivenTransition?.cancel()
            }
            self.percentDrivenTransition = nil
        }
    }
    
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == UINavigationControllerOperation.pop {
            return PopTransion()
        } else {
            return nil
        }
    }
    
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if animationController is PopTransion {
            return self.percentDrivenTransition
        } else {
            return nil
        }
    }
}
