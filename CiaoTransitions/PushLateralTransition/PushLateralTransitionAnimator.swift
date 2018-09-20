//
//  SwipeLateralTransitionAnimator.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 13/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit

class PushLateralTransitionAnimator: CiaoTransitionAnimator {
    
    override func presentingControllerFrame(transitionContext: UIViewControllerContextTransitioning) -> CGRect {
        
        let frame: CGRect = transitionContext.containerView.bounds
        // On iOS 8, UIKit handles rotation using transform matrix
        // Therefore we should always return a frame for portrait mode
        return CGRect(x: frame.size.width, y: 0, width: frame.size.width, height: frame.size.height)
    }
}
