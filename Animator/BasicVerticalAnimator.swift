//
//  BasicVerticalAnimator.swift
//  CiaoTransitions
//
//  Created by Alberto Aznar de los Ríos on 21/9/18.
//

import Foundation

class BasicVerticalAnimator: BasicAnimator {
    
    override func originFrame(byTransitionContext transitionContext: UIViewControllerContextTransitioning) -> CGRect {
        let frame: CGRect = transitionContext.containerView.bounds
        return CGRect(x: 0, y: frame.size.height, width: frame.size.width, height: frame.size.height)
    }
}
