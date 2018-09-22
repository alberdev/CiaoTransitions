//
//  PresentModalAppStoreAnimation.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 16/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit

class PresentAppStoreAnimator: Animator {
    
    struct Params {
        let fromCardFrame: CGRect
        let fromCell: CiaoCardCollectionViewCell
        let toViewTag: Int
    }
    
    private let params: Params
    private let presentAnimationDuration: TimeInterval
    private let springAnimator: UIViewPropertyAnimator
    private var transitionDriver: PresentAppStoreTransitionDriver?
    
    init(params: Params) {
        self.params = params
        self.springAnimator = PresentAppStoreAnimator.createBaseSpringAnimator(params: params)
        self.presentAnimationDuration = springAnimator.duration
        super.init()
    }
    
    private static func createBaseSpringAnimator(params: Params) -> UIViewPropertyAnimator {
        
        // Damping between 0.7 (far away) and 1.0 (nearer)
        let cardPositionY = params.fromCardFrame.minY
        let distanceToBounce = abs(params.fromCardFrame.minY)
        let extentToBounce = cardPositionY < 0 ? params.fromCardFrame.height : UIScreen.main.bounds.height
        let dampFactorInterval: CGFloat = 0.3
        let damping: CGFloat = 1.0 - dampFactorInterval * (distanceToBounce / extentToBounce)
        
        // Duration between 0.5 (nearer) and 0.9 (nearer)
        let baselineDuration: TimeInterval = 0.9
        let maxDuration: TimeInterval = 0.9
        let duration: TimeInterval = baselineDuration + (maxDuration - baselineDuration) * TimeInterval(max(0, distanceToBounce)/UIScreen.main.bounds.height)
        
        // Create spring animator with damping & duration values
        let springTiming = UISpringTimingParameters(dampingRatio: damping, initialVelocity: .init(dx: 0, dy: 0))
        return UIViewPropertyAnimator(duration: duration, timingParameters: springTiming)
    }
}

extension PresentAppStoreAnimator {
    
    override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return presentAnimationDuration
    }
    
    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        transitionDriver = PresentAppStoreTransitionDriver(params: params,
                                                       transitionContext: transitionContext,
                                                       baseAnimator: springAnimator)
        interruptibleAnimator(using: transitionContext).startAnimation()
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        transitionDriver = nil
        params.fromCell.enableAnimations = true
//        scrollView?.isScrollEnabled = true
    }
    
    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        return transitionDriver!.animator
    }
}

