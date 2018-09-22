//
//  BasicLateralAnimator.swift
//  CiaoTransitions
//
//  Created by Alberto Aznar de los Ríos on 21/9/18.
//

import Foundation

class BasicLateralAnimator: BasicAnimator {
    
    override func originFrame(byTransitionContext transitionContext: UIViewControllerContextTransitioning) -> CGRect {
        let frame: CGRect = transitionContext.containerView.bounds
        return CGRect(x: frame.size.width, y: 0, width: frame.size.width, height: frame.size.height)
    }
}
