//
//  PresentAppStoreTransitionDrive.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 16/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit

/// This will select how card is expanded in the collection view (for AppStore modal transition)
enum PresentationStyle {
    /// Expanding card pinning at the top of animatingContainerView
    case fromTop
    /// Expanding card pinning at the center of animatingContainerView
    case fromCenter
}

class PresentAppStoreTransitionDriver {
    
    struct Constants {
        static let presentationStyle = PresentationStyle.fromTop
        static let debugEnabled = Globals.debugEnabled
        static let topInsetFixEnabled = Globals.topInsetFixEnabled
        static let cornerRadius = Globals.cardCornerRadius
    }
    
    let animator: UIViewPropertyAnimator
    
    init(params: PresentAppStoreAnimator.Params, transitionContext: UIViewControllerContextTransitioning, baseAnimator: UIViewPropertyAnimator) {
        
        let ctx = transitionContext
        let container = ctx.containerView
        
        guard
            let detail = ctx.viewController(forKey: .to),
            let cardContentView = detail.view.viewWithTag(params.toViewTag)
            else {
                self.animator = baseAnimator
                return
        }
        
        let detailView = ctx.view(forKey: .to)!
        let fromCardFrame = params.fromCardFrame
        
        // Temporary container view for animation
        let animatedContainerView = UIView()
        animatedContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        if Constants.debugEnabled {
            animatedContainerView.layer.borderColor = UIColor.yellow.cgColor
            animatedContainerView.layer.borderWidth = 4
            detailView.layer.borderColor = UIColor.red.cgColor
            detailView.layer.borderWidth = 2
        }
        container.addSubview(animatedContainerView)
        
        do /* Fix centerX/width/height of animated container to container */ {
            let animatedContainerConstraints = [
                animatedContainerView.widthAnchor.constraint(equalToConstant: container.bounds.width),
                animatedContainerView.heightAnchor.constraint(equalToConstant: container.bounds.height),
                animatedContainerView.centerXAnchor.constraint(equalTo: container.centerXAnchor)
            ]
            NSLayoutConstraint.activate(animatedContainerConstraints)
        }
        
        let animatedContainerVerticalConstraint: NSLayoutConstraint = {
            switch Constants.presentationStyle {
            case .fromCenter:
                return animatedContainerView.centerYAnchor.constraint(
                    equalTo: container.centerYAnchor,
                    constant: (fromCardFrame.height/2 + fromCardFrame.minY) - container.bounds.height/2
                )
            case .fromTop:
                return animatedContainerView.topAnchor.constraint(equalTo: container.topAnchor, constant: fromCardFrame.minY)
            }
        }()
        animatedContainerVerticalConstraint.isActive = true
        
        animatedContainerView.addSubview(detailView)
        detailView.translatesAutoresizingMaskIntoConstraints = false
        
        // let weirdCardToAnimatedContainerTopAnchor: NSLayoutConstraint
        
        do /* Pin top (or center Y) and center X of the card, in animated container view */ {
            let verticalAnchor: NSLayoutConstraint = {
                switch Constants.presentationStyle {
                case .fromCenter:
                    return detailView.centerYAnchor.constraint(equalTo: animatedContainerView.centerYAnchor)
                case .fromTop:
                    // WTF: SUPER WEIRD BUG HERE.
                    // I should set this constant to 0 (or nil), to make cardDetailView sticks to the animatedContainerView's top.
                    // BUT, I can't set constant to 0, or any value in range (-1,1) here, or there will be abrupt top space inset while animating.
                    // Funny how -1 and 1 work! WTF. You can try set it to 0.
                    return detailView.topAnchor.constraint(equalTo: animatedContainerView.topAnchor, constant: -1)
                }
            }()
            let cardConstraints = [
                verticalAnchor,
                detailView.centerXAnchor.constraint(equalTo: animatedContainerView.centerXAnchor),
                ]
            NSLayoutConstraint.activate(cardConstraints)
        }
        let cardWidthConstraint = detailView.widthAnchor.constraint(equalToConstant: fromCardFrame.width)
        let cardHeightConstraint = detailView.heightAnchor.constraint(equalToConstant: fromCardFrame.height)
        NSLayoutConstraint.activate([cardWidthConstraint, cardHeightConstraint])
        
        detailView.layer.cornerRadius = Constants.cornerRadius
        
        // -------------------------------
        // Final preparation
        // -------------------------------
        params.fromCell.isHidden = true
        params.fromCell.resetTransform()
        
        let topTemporaryFix = cardContentView.topAnchor.constraint(equalTo: detailView.topAnchor, constant: 0)
        topTemporaryFix.isActive = Constants.topInsetFixEnabled
        
        container.layoutIfNeeded()
        
        baseAnimator.addAnimations {
            
            // Spring animation for bouncing up
            animatedContainerVerticalConstraint.constant = 0
            container.layoutIfNeeded()
            
            // Linear animation for expansion
            // Animate card filling up the container
            let cardExpanding = UIViewPropertyAnimator(duration: baseAnimator.duration * 0.6, curve: .linear) {
                cardWidthConstraint.constant = animatedContainerView.bounds.width
                cardHeightConstraint.constant = animatedContainerView.bounds.height
                detailView.layer.cornerRadius = 0
                container.layoutIfNeeded()
            }
            cardExpanding.startAnimation()
        }
        
        baseAnimator.addCompletion { (_) in
            
            // Complete everything
            // Remove temporary `animatedContainerView`
            animatedContainerView.removeConstraints(animatedContainerView.constraints)
            animatedContainerView.removeFromSuperview()
            
            // Re-add to the top
            container.addSubview(detailView)
            
            detailView.removeConstraints([topTemporaryFix, cardWidthConstraint, cardHeightConstraint])
            
            // Keep -1 to be consistent with the weird bug above.
            detailView.constraints(to: container, top: -1)
            
            // No longer need the bottom constraint that pins bottom of card content to its root.
            // detail.cardBottomToRootBottomConstraint.isActive = false
//            scrollView?.isScrollEnabled = true
            
            let success = !ctx.transitionWasCancelled
            ctx.completeTransition(success)
        }
        
        self.animator = baseAnimator
    }
}
