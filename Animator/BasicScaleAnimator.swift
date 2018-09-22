//
//  BasicScaleAnimator.swift
//  CiaoTransitions
//
//  Created by Alberto Aznar de los Ríos on 22/9/18.
//

import Foundation

class BasicScaleAnimator: BasicAnimator {
    
    override func originFrame(byTransitionContext transitionContext: UIViewControllerContextTransitioning) -> CGRect {
        let frame: CGRect = transitionContext.containerView.bounds
        return CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
    }
}
