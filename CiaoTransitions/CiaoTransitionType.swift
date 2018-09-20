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
        
        case pushLateral
        case pushVertical
        case pushScaleImage
        
        func animatorController(direction: CiaoTransitionDirection, params: CiaoTransition.Params, scaleParams: CiaoTransition.ScaleParams?) -> CiaoTransitionAnimator? {
            
            switch self {
            case .pushLateral:
                
                let swipeLateralAnimator = PushLateralTransitionAnimator(
                    direction: direction,
                    params: params)
                
                return direction == .dismissal ? swipeLateralAnimator : nil
                
            case .pushVertical: return PushVerticalTransitionAnimator(direction: direction, params: params)
            case .pushScaleImage: return PushScaleTransitionAnimator(direction: direction, params: params, scaleParams: scaleParams)
            }
        }
        
        func interactorController(params: CiaoTransition.Params, navigationController: UINavigationController? = nil, presentedViewController: UIViewController? = nil) -> CiaoTransitionInteractor? {
            switch self {
                
            case .pushLateral: return PushLateralTransitionInteractor(params: params, navigationController: navigationController, presentedViewController: presentedViewController)
            case .pushVertical: return PushVerticalTransitionInteractor(params: params, navigationController: navigationController, presentedViewController: presentedViewController)
            case .pushScaleImage: return PushScaleTransitionInteractor(params: params, navigationController: navigationController, presentedViewController: presentedViewController)
            }
        }
    }

    public enum Modal {
        
        case modalAppStore
        
        func animatorController(direction: CiaoTransitionDirection, params: CiaoTransition.Params, scaleParams: CiaoTransition.ScaleParams?) -> CiaoTransitionAnimator? {
        
            switch self {
            case .modalAppStore: return nil
            }
        }
        
        func interactorController(params: CiaoTransition.Params, navigationController: UINavigationController? = nil, presentedViewController: UIViewController? = nil) -> CiaoTransitionInteractor? {
            
            switch self {
            case .modalAppStore: return DismissAppStoreInteractor(params: params, navigationController: navigationController, presentedViewController: presentedViewController)
            }
        }
    }
}
