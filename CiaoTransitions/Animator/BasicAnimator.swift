//
//  Animator.swift
//  CiaoTransitions
//
//  Created by Alberto Aznar de los Ríos on 21/9/18.
//

import UIKit

class BasicAnimator: Animator {
    
    struct Params {
        // basic params
        var duration: TimeInterval = 0.8
        var presentCompletion: (()->Void)? = nil
        var dismissCompletion: (()->Void)? = nil
        var fadeOutEnabled = true
        var fadeInEnabled = false
        var scale3D = false
        var lateralTranslationEnabled = true
        // scale params
        var scaleSourceImageView: UIImageView?
        var scaleSourceFrame: CGRect?
        var scaleDestImageViewTag: Int?
        var scaleDestFrame: CGRect?
    }
    
    var params: Params
    private var transitionView: UIImageView?
    
    init(params: Params? = nil) {
        self.params = params ?? Params()
    }
    
    func originFrame(byTransitionContext transitionContext: UIViewControllerContextTransitioning) -> CGRect {
        return transitionContext.containerView.bounds
    }
}

extension BasicAnimator {
    
    override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return params.duration
    }
    
    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        guard
            let toView = transitionContext.view(forKey: .to),
            let fromView = transitionContext.view(forKey: .from)
            else { return }
        
        let detailView = presenting ? toView : fromView
        let mainView = presenting ? fromView : toView
        
        // Move destination snapshot back in Z plane
        // Important: original transform3d is different from CATransform3DIdentity
        let originalTransform: CATransform3D = mainView.layer.transform
        
        if presenting {
            detailView.frame = originFrame(byTransitionContext: transitionContext)
            detailView.clipsToBounds = true
            detailView.alpha = params.fadeInEnabled ? 0.0 : 1.0
        } else {
            mainView.alpha = params.fadeOutEnabled ? 0.0 : 1.0
            var perspectiveTransform: CATransform3D = originalTransform
            perspectiveTransform.m34 = params.scale3D ? 1.0 / -1000.0 : perspectiveTransform.m34
            perspectiveTransform = CATransform3DTranslate(perspectiveTransform, params.lateralTranslationEnabled ? -120 : 0, 0, -100)
            mainView.layer.transform = perspectiveTransform
        }
        
        containerView.addSubview(toView)
        containerView.bringSubview(toFront: detailView)
        
        // Image scaling
        if
            let scaleSourceImageView = params.scaleSourceImageView,
            let scaleSourceFrame = params.scaleSourceFrame,
            let scaleDestFrame = params.scaleDestFrame,
            let scaleDestImageViewTag = params.scaleDestImageViewTag,
            let scaleDestImageView = detailView.viewWithTag(scaleDestImageViewTag) as? UIImageView {
            transitionView = scaleSourceImageView.clone()
            transitionView?.frame = presenting ? scaleSourceFrame : scaleDestFrame
            scaleSourceImageView.alpha = 0
            scaleDestImageView.alpha = 0
            containerView.addSubview(transitionView!)
        }
        
        UIView.animateKeyframes(withDuration: params.duration, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: { () -> Void in
        //UIView.animate(withDuration: params.duration, delay:0.0, usingSpringWithDamping: 0.0, initialSpringVelocity: 0.0, animations: {
            
            if
                let scaleDestFrame = self.params.scaleDestFrame,
                let scaleSourceFrame = self.params.scaleSourceFrame {
                self.transitionView?.frame = self.presenting ? scaleDestFrame : scaleSourceFrame
            }
            
            if self.presenting {
                detailView.frame = containerView.bounds
                detailView.alpha = 1.0
                mainView.alpha = self.params.fadeOutEnabled ? 0.0 : 1.0
                
                var perspectiveTransform: CATransform3D = mainView.layer.transform
                perspectiveTransform.m34 = self.params.scale3D ? 1.0 / -1000.0 : perspectiveTransform.m34
                perspectiveTransform = CATransform3DTranslate(perspectiveTransform, self.params.lateralTranslationEnabled ? -120 : 0, 0, -100)
                mainView.layer.transform = perspectiveTransform
                
            } else {
                detailView.frame = self.originFrame(byTransitionContext: transitionContext)
                detailView.alpha = self.params.fadeInEnabled ? 0.0 : 1.0
                mainView.alpha = 1.0
                mainView.layer.transform = originalTransform
            }
            
        }, completion: { _ in
            mainView.layer.transform = CATransform3DIdentity
            self.presenting ? self.params.presentCompletion?() : self.params.dismissCompletion?()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            
            // Remove transition image
            if
                let scaleSourceImageView = self.params.scaleSourceImageView,
                let scaleDestImageViewTag = self.params.scaleDestImageViewTag,
                let scaleDestImageView = detailView.viewWithTag(scaleDestImageViewTag) as? UIImageView {
                scaleSourceImageView.alpha = 1.0
                scaleDestImageView.alpha = 1.0
                self.transitionView?.removeFromSuperview()
            }
        })
    }
}
