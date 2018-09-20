//
//  CiaoTransitionDirection.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 11/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit

enum CiaoTransitionDirection {
    
    case present
    case dismissal
    
    static func by(transitionContext: UIViewControllerContextTransitioning, fromViewController: UIViewController?, toViewController: UIViewController?) -> CiaoTransitionDirection? {
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
            else { return nil }
        
        print("SOURCE: \(source)")
        print("DESTINATION: \(destination)")
        
        return source == fromViewController && destination == toViewController ? .present : .dismissal
    }
}
