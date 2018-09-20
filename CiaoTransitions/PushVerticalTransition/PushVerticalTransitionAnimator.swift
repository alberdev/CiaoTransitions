//
//  SwipeFadeTransitionAnimator.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 11/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit

class PushVerticalTransitionAnimator: CiaoTransitionAnimator {
    
    override func presentingControllerFrame(transitionContext: UIViewControllerContextTransitioning) -> CGRect {
        let frame: CGRect = transitionContext.containerView.bounds
        return CGRect(x: 0, y: frame.size.height, width: frame.size.width, height: frame.size.height)
    }
}
