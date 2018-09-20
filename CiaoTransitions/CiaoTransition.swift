//
//  CiaoManager.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 11/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit

open class CiaoTransition: NSObject {
    
    public struct Params {
        
        public var presentDuration = Globals.presentAnimationDuration
        public var presentFadeEnabled = Globals.presentFadeEnabled
        public var backfadeEnabled = Globals.backfadeEnabled
        public var backScaleEnabled = Globals.backScaleEnabled
        public var backLateralTranslationEnabled = Globals.backLateralTranslationEnabled
        public var dragLateralEnabled = Globals.dragLateralEnabled
        public var dragDownEnabled = Globals.dragDownEnabled
        
        public init() {}
    }
    
    public struct ScaleParams {
        
        public var sourceImageView: UIImageView?
        public var sourceFrame: CGRect = CGRect.zero
        public var destImageViewTag: Int = 100000000
        public var destFrame: CGRect = CGRect.zero
        
        public init() {}
    }
    
    private struct AppStoreParams {
        var fromCardFrame: CGRect
        var fromCardFrameWithoutTransform: CGRect
        var fromCell: CiaoCardCollectionViewCell
        var toViewTag: Int
    }
    
    /// Interactor controller & animator controller are used for transition animations.
    /// Interactor drives an interactive animation between one view controller and another.
    /// Animator is the place where fancy animations are implemented.
    private var interactorController: CiaoTransitionInteractor?
    private var animatorController: CiaoTransitionAnimator?
    
    private var pushType: CiaoTransitionType.Push?
    private var modalType: CiaoTransitionType.Modal?
    private var params: Params
    private var scaleParams: ScaleParams?
    private var appstoreParams: AppStoreParams?
    private var toViewTag: Int = 100000000
    
    open var fromCell: CiaoCardCollectionViewCell? {
        didSet {
            guard
                let cell = fromCell,
                let currentCellFrame = cell.layer.presentation()?.frame, // Get current frame on screen
                let cardPresentationFrameOnScreen = cell.superview?.convert(currentCellFrame, to: nil)
                else { return }
            
            cell.enableAnimations = false
            
            // Get card frame without transform in screen's coordinates
            // (for the dismissing back later to original location)
            let cardFrameWithoutTransform = { () -> CGRect in
                let center = cell.center
                let size = cell.bounds.size
                let r = CGRect(
                    x: center.x - size.width / 2,
                    y: center.y - size.height / 2,
                    width: size.width,
                    height: size.height
                )
                return cell.superview!.convert(r, to: nil)
            }()
            
            appstoreParams = CiaoTransition.AppStoreParams(
                fromCardFrame: cardPresentationFrameOnScreen,
                fromCardFrameWithoutTransform: cardFrameWithoutTransform,
                fromCell: cell,
                toViewTag: toViewTag)
        }
    }
    
    /// REQUIRED!
    /// This is the view we use to get gestures and start the transition.
    /// Is required to make transitions working.
    /// Assign the scroll view or static view you want once view is loaded.
    open var scrollView: UIScrollView? {
        didSet {
            interactorController?.scrollView = scrollView
        }
    }
    
    public init(pushTransitionType pushType: CiaoTransitionType.Push, params: Params = Params(), scaleParams: ScaleParams? = nil) {
        self.pushType = pushType
        self.params = params
        self.scaleParams = scaleParams
    }
    
    public init(modalTransitionType modalType: CiaoTransitionType.Modal, params: Params = Params(), toViewTag: Int) {
        self.modalType = modalType
        self.params = params
        self.toViewTag = toViewTag
    }
}

/// PUSH & POP
/// The navigation controller delegate has two methods that are responsible for custom push and pop animations
/// It's almost the same as the transitioning delegate for the view controllers

extension CiaoTransition: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        guard let interactor = interactorController else { return nil }
        return interactor.transitionInProgress ? interactorController : nil
    }
    
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .push {
            interactorController = pushType?.interactorController(params: params, navigationController: toVC.navigationController, presentedViewController: toVC)
            interactorController?.scrollView = scrollView
            animatorController = pushType?.animatorController(direction: .present, params: params, scaleParams: scaleParams)
            return animatorController
        } else {
            animatorController = pushType?.animatorController(direction: .dismissal, params: params, scaleParams: scaleParams)
            return animatorController
        }
    }
}

/// MODAL
/// The view controller transitioning delegate has different methods that are responsible for custom modal animations
/// Every view controller can have a transition delegate, in this delegate implementation, custom animation and
/// interaction controllers are provided.

extension CiaoTransition: UIViewControllerTransitioningDelegate {
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let appstoreParams = appstoreParams else { return nil }
        let presentParams = PresentAppStoreAnimator.Params.init(
            fromCardFrame: appstoreParams.fromCardFrame,
            fromCell: appstoreParams.fromCell,
            toViewTag: appstoreParams.toViewTag
        )
        interactorController = modalType?.interactorController(params: params, presentedViewController: presented)
        interactorController?.scrollView = scrollView
        return PresentAppStoreAnimator(params: presentParams, inScrollView: scrollView)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let appstoreParams = appstoreParams else { return nil }
        let params = DismissAppStoreAnimator.Params.init(
            fromCardFrame: appstoreParams.fromCardFrame,
            fromCardFrameWithoutTransform: appstoreParams.fromCardFrameWithoutTransform,
            fromCell: appstoreParams.fromCell,
            toViewTag: appstoreParams.toViewTag
        )
        return DismissAppStoreAnimator(params: params, inScrollView: scrollView)
    }
    
    public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let interactor = interactorController else { return nil }
        return interactor.transitionInProgress ? interactorController : nil
    }
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return CiaoModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
