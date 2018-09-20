//
//  CiaoTransitionType.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 11/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit

public enum CiaoTransitionType {

    public enum Push {
        
        case lateral
        case vertical
        case scaleImage
        
        func animatorController(direction: CiaoTransitionDirection, params: CiaoTransition.Params, scaleParams: CiaoTransition.ScaleParams?) -> CiaoTransitionAnimator? {
            
            switch self {
            case .lateral:
                
                let swipeLateralAnimator = PushLateralTransitionAnimator(
                    direction: direction,
                    params: params)
                
                return direction == .dismissal ? swipeLateralAnimator : nil
                
            case .vertical: return PushVerticalTransitionAnimator(direction: direction, params: params)
            case .scaleImage: return PushScaleTransitionAnimator(direction: direction, params: params, scaleParams: scaleParams)
            }
        }
        
        func interactorController(params: CiaoTransition.Params, navigationController: UINavigationController? = nil, presentedViewController: UIViewController? = nil) -> CiaoTransitionInteractor? {
            switch self {
                
            case .lateral: return PushLateralTransitionInteractor(params: params, navigationController: navigationController, presentedViewController: presentedViewController)
            case .vertical: return PushVerticalTransitionInteractor(params: params, navigationController: navigationController, presentedViewController: presentedViewController)
            case .scaleImage: return PushScaleTransitionInteractor(params: params, navigationController: navigationController, presentedViewController: presentedViewController)
            }
        }
    }

    public enum Modal {
        
        case appStore
        
        func animatorController(direction: CiaoTransitionDirection, params: CiaoTransition.Params, scaleParams: CiaoTransition.ScaleParams?) -> CiaoTransitionAnimator? {
        
            switch self {
            case .appStore: return nil
            }
        }
        
        func interactorController(params: CiaoTransition.Params, navigationController: UINavigationController? = nil, presentedViewController: UIViewController? = nil) -> CiaoTransitionInteractor? {
            
            switch self {
            case .appStore: return DismissAppStoreInteractor(params: params, navigationController: navigationController, presentedViewController: presentedViewController)
            }
        }
    }
}
