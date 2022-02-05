//
//  IconAnimationImageView.swift
//  checklist
//
//  Created by 北島　志帆美 on 2020-06-07.
//  Copyright © 2020 北島　志帆美. All rights reserved.
//

import UIKit

protocol pushHomeVCDelegate: class {
    func push()
}

class IconAnimationImageView: UIImageView {
    
    weak var delegate: pushHomeVCDelegate?
    
    
//    func fallAction(startPosition: CGPoint, endPosition: CGPoint) {
//
//        CATransaction.begin()
//
//        let animation = CABasicAnimation(keyPath: "position.y")
//
//        animation.duration = 0.05
//        animation.repeatCount = 5
//        animation.autoreverses = true
//        animation.fromValue = NSValue(cgPoint: CGPoint(x: startPosition.x, y: startPosition.y))
//        animation.toValue = NSValue(cgPoint: CGPoint(x: endPosition.x, y: endPosition.y))
//
//        CATransaction.setCompletionBlock {
//
//
//            // arrange initialSpringVelocity to bounce, uiview bounce if its number bigger and bigger
//            UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 40, options: UIView.AnimationOptions.curveEaseOut, animations: {
//
//                self.center.y += 30
//
//
//            }, completion: { _ in
//                self.shakeAction()
//            })
//
//        }
//
//
//        self.layer.add(animation, forKey: "position.y")
//
//        CATransaction.commit()
//    }
    
    func bounceAction() {
        
        // arrange initialSpringVelocity to bounce, uiview bounce if its number bigger and bigger
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 40, options: UIView.AnimationOptions.curveEaseOut, animations: {
            
            self.center.y += 30
            
            
        }, completion: { _ in
            self.shakeAction()
        })
        
    }
    
    func shakeAction() {
        
        CATransaction.begin()
        
        let animation = CABasicAnimation(keyPath: "position")
        
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4, y: self.center.y))
        
        CATransaction.setCompletionBlock {
            self.sizeShrink()
            
        }
        
        
        self.layer.add(animation, forKey: "position")
        
        CATransaction.commit()
    }
    
    
    func sizeShrink() {
        
        UIView.animate(withDuration: 0.3,
                              delay: 0,
                              options: UIView.AnimationOptions.curveEaseOut,
                              animations: { () in
                               self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
               }, completion: { (Bool) in
                   
                self.sizeExtend()
               })
        
    
    }
    
    func sizeExtend() {
        
        //8倍まで拡大！
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       options: UIView.AnimationOptions.curveEaseOut,
                       animations: { () in
                        self.transform = CGAffineTransform(scaleX: 8.0, y: 8.0)
                        self.alpha = 0
        }, completion: { (Bool) in
            //で、アニメーションが終わったらimageViewを消す
            self.removeFromSuperview()
            self.delegate?.push()
        })
    }
    
}
