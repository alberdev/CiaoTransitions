//
//  CiaoTransitionAnimator.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 12/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit

class CiaoTransitionAnimator: NSObject {
    
    private var direction: CiaoTransitionDirection
    private var params: CiaoTransition.Params
    private var scaleParams: CiaoTransition.ScaleParams?
    private var transitionView: UIImageView?
    
    init(direction : CiaoTransitionDirection, params: CiaoTransition.Params, scaleParams: CiaoTransition.ScaleParams? = nil) {
        self.direction = direction
        self.params = params
        self.scaleParams = scaleParams
    }
    
    /// Calculate a final frame for presenting controller according to interface orientation
    /// Presenting controller should always slide down and its top should coincide with the bottom of screen
    func presentingControllerFrame(transitionContext: UIViewControllerContextTransitioning) -> CGRect {
        return transitionContext.containerView.bounds
    }
    
    func animatePresentation(transitionContext: UIViewControllerContextTransitioning) {
        
        let source: UIViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let destination: UIViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let container: UIView = transitionContext.containerView
        
        // Orientation bug fix
        destination.view.frame = container.bounds
        source.view.frame = container.bounds
        
        // Opacity View
        destination.view.alpha = params.presentFadeEnabled ? 0.0 : 1.0
        
        // Move destination view below source view
        destination.view.frame = self.presentingControllerFrame(transitionContext: transitionContext)
        
        // Add destination view to container
        container.addSubview(destination.view)
        
        // Start appearance transition for destination controller
        // Because UIKit does not do this automatically
        destination.beginAppearanceTransition(true, animated: true)
        
        // Image scaling
        if
            let scaleParams = scaleParams,
            let sourceImageView = scaleParams.sourceImageView,
            let destImageView = destination.view.viewWithTag(scaleParams.destImageViewTag) as? UIImageView {
            transitionView = sourceImageView.clone()
            transitionView?.frame = scaleParams.sourceFrame
            destImageView.alpha = 0
            container.addSubview(transitionView!)
        }
        
        // Animate
        UIView.animateKeyframes(withDuration: params.presentDuration, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: { () -> Void in
            
            if
                let scaleParams = self.scaleParams {
                self.transitionView?.frame = scaleParams.destFrame
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.7, animations: { () -> Void in
                destination.view.frame = container.bounds
                destination.view.alpha = 1.0
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.7, animations: { () -> Void in
                // Important: original transform3d is different from CATransform3DIdentity
                var perspectiveTransform: CATransform3D = source.view.layer.transform
                perspectiveTransform.m34 = self.params.backScaleEnabled ? 1.0 / -1000.0 : perspectiveTransform.m34
                perspectiveTransform = CATransform3DTranslate(perspectiveTransform, 0, 0, -100)
                source.view.layer.transform = perspectiveTransform
                source.view.alpha = self.params.presentFadeEnabled ? 1.0 : 0.0
            })
            
        }) { (finished) -> Void in
            // End appearance transition for destination controller
            destination.endAppearanceTransition()
            source.view.layer.transform = CATransform3DIdentity
            source.view.alpha = 1.0
            // Finish transition
            transitionContext.completeTransition(true)
            // Remove transition image
            if
                let scaleParams = self.scaleParams,
                let destImageView = destination.view.viewWithTag(scaleParams.destImageViewTag) as? UIImageView {
                destImageView.alpha = 1
                self.transitionView?.removeFromSuperview()
            }
        }
    }
    
    func animateDismissal(transitionContext: UIViewControllerContextTransitioning) {
        
        let source: UIViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let destination: UIViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let container: UIView = transitionContext.containerView
        
        // Orientation bug fix
        destination.view.frame = container.bounds
        source.view.frame = container.bounds
        
        // Opacity View
        destination.view.alpha = params.backfadeEnabled ? 0.0 : 1.0
        
        // Place container view before source view
        container.superview?.sendSubview(toBack: container)
        
        // Add destination view to container
        container.addSubview(destination.view)
        
        // Move destination snapshot back in Z plane
        // Important: original transform3d is different from CATransform3DIdentity
        let originalTransform: CATransform3D = destination.view.layer.transform
        
        // Apply custom transform
        var perspectiveTransform: CATransform3D = originalTransform
        perspectiveTransform.m34 = params.backScaleEnabled ? 1.0 / -1000.0 : perspectiveTransform.m34
        perspectiveTransform = CATransform3DTranslate(perspectiveTransform, params.backLateralTranslationEnabled ? -120 : 0, 0, -100)
        destination.view.layer.transform = perspectiveTransform
        
        // Start appearance transition for source controller
        // UIKit does not do this automatically
        source.beginAppearanceTransition(false, animated: true)
        
        // Image scaling
        if
            let scaleParams = scaleParams,
            let sourceImageView = scaleParams.sourceImageView,
            let destImageView = source.view.viewWithTag(scaleParams.destImageViewTag) as? UIImageView {
            transitionView = destImageView.clone()
            transitionView?.frame = scaleParams.destFrame
            sourceImageView.alpha = 0
            destImageView.alpha = 0
            container.addSubview(transitionView!)
        }
        
        // Animate
        UIView.animateKeyframes(withDuration: params.presentDuration, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: { () -> Void in
            
            if
                let scaleParams = self.scaleParams {
                self.transitionView?.frame = scaleParams.sourceFrame
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0, animations: { () -> Void in
                source.view.frame = self.presentingControllerFrame(transitionContext: transitionContext)
                destination.view.alpha = 1.0
            })
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.9, animations: { () -> Void in
                destination.view.layer.transform = originalTransform
                source.view.alpha = self.params.presentFadeEnabled ? 0.0 : 1.0
            })
            
        }) { (finished) -> Void in
            // End appearance transition for source controller
            source.endAppearanceTransition()
            
            // Finish transition
            if (transitionContext.transitionWasCancelled) {
                destination.view.layer.transform = CATransform3DIdentity
            }
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            
            // Remove transition image
            if
                let scaleParams = self.scaleParams,
                let sourceImageView = scaleParams.sourceImageView,
                let destImageView = source.view.viewWithTag(scaleParams.destImageViewTag) as? UIImageView {
                sourceImageView.alpha = 1
                destImageView.alpha = 1
                self.transitionView?.removeFromSuperview()
            }
        }
    }
}

extension CiaoTransitionAnimator: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return params.presentDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch direction {
        case .present: animatePresentation(transitionContext: transitionContext)
        case .dismissal: animateDismissal(transitionContext: transitionContext)
        }
    }
}
