//
//  TransitionStyle.swift
//  CiaoTransitions
//
//  Created by Alberto Aznar de los Ríos on 22/9/18.
//

import UIKit

public enum CiaoTransitionStyle {
    
    case vertical
    case lateral
    case scaleImage
    case appStore
    
    func animator(configurator: CiaoConfigurator, scaleConfigurator: CiaoScaleConfigurator?) -> Animator {
        
        let basicParams = BasicAnimator.Params(
            duration: configurator.duration,
            presentCompletion: configurator.presentCompletion,
            dismissCompletion: configurator.dismissCompletion,
            fadeOutEnabled: configurator.fadeOutEnabled,
            fadeInEnabled: configurator.fadeInEnabled,
            scale3D: configurator.scale3D,
            lateralTranslationEnabled: configurator.lateralTranslationEnabled,
            scaleSourceImageView: scaleConfigurator?.scaleSourceImageView,
            scaleSourceFrame: scaleConfigurator?.scaleSourceFrame,
            scaleDestImageViewTag: scaleConfigurator?.scaleDestImageViewTag,
            scaleDestFrame: scaleConfigurator?.scaleDestFrame)
        
        switch self {
        case .vertical: return BasicVerticalAnimator(params: basicParams)
        case .lateral: return BasicLateralAnimator(params: basicParams)
        case .scaleImage: return BasicScaleAnimator(params: basicParams)
        case .appStore: return BasicLateralAnimator(params: basicParams)
        }
        
    }
    
    func interactor(configurator: CiaoConfigurator) -> Interactor {
        
        let basicParams = Interactor.Params(
            dragLateralEnabled: configurator.dragLateralEnabled,
            dragDownEnabled: configurator.dragDownEnabled)
        
        switch self {
        case .vertical: return BasicInteractor(params: basicParams)
        case .lateral: return BasicInteractor(params: basicParams)
        case .scaleImage: return BasicInteractor(params: basicParams)
        case .appStore: return SpecialInteractor(params: basicParams)
        }
    }
}
