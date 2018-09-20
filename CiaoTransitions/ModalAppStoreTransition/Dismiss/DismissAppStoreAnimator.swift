//
//  DismissAppStoreAnimator.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 17/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit

final class DismissAppStoreAnimator: NSObject {
    
    struct Params {
        let fromCardFrame: CGRect
        let fromCardFrameWithoutTransform: CGRect
        let fromCell: CiaoCardCollectionViewCell
        let toViewTag: Int
    }
    
    struct Constants {
        static let relativeDurationBeforeNonInteractive: TimeInterval = 0.5
        static let minimumScaleBeforeNonInteractive: CGFloat = 0.8
        static let dismissalAnimationDuration: TimeInterval = Globals.dismissalAnimationDuration
        static let debugEnabled = Globals.debugEnabled
        static let topInsetFixEnabled = Globals.topInsetFixEnabled
    }
    
    private let params: Params
    private var scrollView: UIScrollView?
    
    init(params: Params, inScrollView scrollView: UIScrollView?) {
        self.params = params
        self.scrollView = scrollView
        super.init()
    }
}

extension DismissAppStoreAnimator: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Constants.dismissalAnimationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let ctx = transitionContext
        let container = ctx.containerView
        
        guard
            let detail = ctx.viewController(forKey: .from) as? CiaoBaseViewController,
            let cardContentView = detail.view.viewWithTag(params.toViewTag)
            else { return }
        
        let cardDetailView = ctx.view(forKey: .from)!
        
        let animatedContainerView = UIView()
        
        if Constants.debugEnabled {
            animatedContainerView.layer.borderColor = UIColor.yellow.cgColor
            animatedContainerView.layer.borderWidth = 4
            cardDetailView.layer.borderColor = UIColor.red.cgColor
            cardDetailView.layer.borderWidth = 2
        }
        
        animatedContainerView.translatesAutoresizingMaskIntoConstraints = false
        cardDetailView.translatesAutoresizingMaskIntoConstraints = false
        
        container.removeConstraints(container.constraints)
        container.addSubview(animatedContainerView)
        animatedContainerView.addSubview(cardDetailView)
        cardDetailView.constraints(to: animatedContainerView)
        
        // Constraints for animatedContainerView
        animatedContainerView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        let animatedContainerTopConstraint = animatedContainerView.topAnchor.constraint(equalTo: container.topAnchor, constant: 0)
        let animatedContainerWidthConstraint = animatedContainerView.widthAnchor.constraint(equalToConstant: cardDetailView.frame.width)
        let animatedContainerHeightConstraint = animatedContainerView.heightAnchor.constraint(equalToConstant: cardDetailView.frame.height)
        
        NSLayoutConstraint.activate([animatedContainerTopConstraint, animatedContainerWidthConstraint, animatedContainerHeightConstraint])
        
        // Fix weird top inset
        let topTemporaryFix = cardContentView.topAnchor.constraint(equalTo: cardDetailView.topAnchor)
        topTemporaryFix.isActive = Constants.topInsetFixEnabled
        
        container.layoutIfNeeded()
        
        // Force card filling bottom
        let stretchCardToFillBottom = cardContentView.bottomAnchor.constraint(equalTo: cardDetailView.bottomAnchor)
        
        UIView.animate(withDuration: transitionDuration(using: ctx), delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [], animations: {
            
            stretchCardToFillBottom.isActive = true
            // Back to identity
            // NOTE: Animated container view in a way, helps us to not messing up `transform` with `AutoLayout` animation.
            cardDetailView.transform = CGAffineTransform.identity
            animatedContainerTopConstraint.constant = self.params.fromCardFrameWithoutTransform.minY
            animatedContainerWidthConstraint.constant = self.params.fromCardFrameWithoutTransform.width
            animatedContainerHeightConstraint.constant = self.params.fromCardFrameWithoutTransform.height
            container.layoutIfNeeded()
            
        }) { (finished) in
            
            let success = !ctx.transitionWasCancelled
            animatedContainerView.removeConstraints(animatedContainerView.constraints)
            animatedContainerView.removeFromSuperview()
            
            if success {
                cardDetailView.removeFromSuperview()
                self.params.fromCell.isHidden = false
            } else {
                // Remove temporary fixes if not success!
                topTemporaryFix.isActive = false
                stretchCardToFillBottom.isActive = false
                
                cardDetailView.removeConstraint(topTemporaryFix)
                cardDetailView.removeConstraint(stretchCardToFillBottom)
                container.removeConstraints(container.constraints)
                container.addSubview(cardDetailView)
                cardDetailView.constraints(to: container)
            }
            ctx.completeTransition(success)
        }
        
        UIView.animate(withDuration: transitionDuration(using: ctx) * 0.6) {
            self.scrollView?.contentOffset = .zero
        }
    }
}
