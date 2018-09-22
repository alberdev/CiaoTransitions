//
//  Transition.swift
//  CiaoTransitions
//
//  Created by Alberto Aznar de los Ríos on 21/9/18.
//

import UIKit

open class CiaoTransition: NSObject {
    
    /// Configurator let's you configure some parameters to customize the animation transition
    private let configurator: CiaoConfigurator
    private let scaleConfigurator: CiaoScaleConfigurator?
    private let appStoreConfigurator: CiaoAppStoreConfigurator?
    
    /// Interactor controller & animator controller are used for transition animations.
    /// Interactor drives an interactive animation between one view controller and another.
    /// Animator is the place where fancy animations are implemented.
    private var interactor: Interactor
    private let animator: Animator
    private let style: CiaoTransitionStyle
    
    public init(style: CiaoTransitionStyle, configurator: CiaoConfigurator? = nil, scaleConfigurator: CiaoScaleConfigurator? = nil, appStoreConfigurator: CiaoAppStoreConfigurator? = nil) {
        self.style = style
        self.configurator = configurator ?? CiaoConfigurator()
        self.scaleConfigurator = scaleConfigurator
        self.appStoreConfigurator = appStoreConfigurator
        self.animator = style.animator(configurator: self.configurator, scaleConfigurator: self.scaleConfigurator)
        self.interactor = style.interactor(configurator: self.configurator)
    }
}

/// PUSH & POP
/// The navigation controller delegate has two methods that are responsible for custom push and pop animations
/// It's almost the same as the transitioning delegate for the view controllers

extension CiaoTransition: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.transitionInProgress ? interactor : nil
    }
    
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if style == .appStore {
            fatalError("App Store transition must be presented not pushed")
        }
        if operation == .push {
            interactor.presentedViewController = toVC
            interactor.navigationController = toVC.navigationController
            animator.presenting = true
            return animator
        } else {
            animator.presenting = false
            return animator
        }
    }
}

/// MODAL
/// The view controller transitioning delegate has different methods that are responsible for custom modal animations
/// Every view controller can have a transition delegate, in this delegate implementation, custom animation and
/// interaction controllers are provided.

extension CiaoTransition: UIViewControllerTransitioningDelegate {
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        interactor.presentedViewController = presented
        
        if style == .appStore, let appStoreConfigurator = appStoreConfigurator {
            
            let presentAppStoreParams = PresentAppStoreAnimator.Params.init(
                fromCardFrame: appStoreConfigurator.fromCardFrame,
                fromCell: appStoreConfigurator.fromCell,
                toViewTag: appStoreConfigurator.toViewTag
            )
            return PresentAppStoreAnimator(params: presentAppStoreParams)
            
        } else {
            animator.presenting = true
            return animator
        }
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if style == .appStore, let appStoreConfigurator = appStoreConfigurator {
            
            let presentAppStoreParams = DismissAppStoreAnimator.Params.init(
                fromCardFrame: appStoreConfigurator.fromCardFrame,
                fromCardFrameWithoutTransform: appStoreConfigurator.fromCardFrameWithoutTransform,
                fromCell: appStoreConfigurator.fromCell,
                toViewTag: appStoreConfigurator.toViewTag
            )
            return DismissAppStoreAnimator(params: presentAppStoreParams)
            
        } else {
            animator.presenting = false
            return animator
        }
    }
    
    public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }

    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.transitionInProgress ? interactor : nil
    }

    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return style == .appStore ?
            CiaoModalPresentationController(presentedViewController: presented, presenting: presenting) :
            nil
    }
}

extension CiaoTransition: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        interactor.scrollViewDidScroll(scrollView)
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        interactor.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
}

