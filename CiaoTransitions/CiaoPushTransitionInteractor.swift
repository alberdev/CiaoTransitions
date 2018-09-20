//
//  CiaoTransitionInteractor.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 12/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit

public class CiaoPushTransitionInteractor: CiaoTransitionInteractor {
    
    var navigationController: UINavigationController?
    var presentedViewController: UIViewController?
    var shouldCompleteTransition = false
    var params: CiaoTransition.Params
    
    final class DismissalPanGesture: UIPanGestureRecognizer {}
    final class DismissalScreenEdgePanGesture: UIScreenEdgePanGestureRecognizer {}
    
    lazy var dismissalPanGesture: DismissalPanGesture = {
        let pan = DismissalPanGesture()
        pan.maximumNumberOfTouches = 1
        return pan
    }()
    
    lazy var dismissalScreenEdgePanGesture: DismissalScreenEdgePanGesture = {
        let pan = DismissalScreenEdgePanGesture()
        pan.edges = .left
        return pan
    }()
    
    override var scrollView: UIScrollView? {
        didSet {
            scrollView?.delegate = self
        }
    }
    
    init(params: CiaoTransition.Params, navigationController: UINavigationController? = nil, presentedViewController: UIViewController? = nil) {
        self.params = params
        super.init()
        self.navigationController = navigationController
        self.presentedViewController = presentedViewController
        self.completionCurve = .linear
        setupGestures()
    }
    
    private func setupGestures() {
        dismissalPanGesture.addTarget(self, action: #selector(panGestureHandler))
        dismissalPanGesture.delegate = self
        dismissalScreenEdgePanGesture.addTarget(self, action: #selector(panGestureHandler))
        dismissalScreenEdgePanGesture.delegate = self
        dismissalPanGesture.require(toFail: dismissalScreenEdgePanGesture)
        
        if params.dragLateralEnabled {
            presentedViewController?.view.addGestureRecognizer(dismissalScreenEdgePanGesture)
        }
        if params.dragDownEnabled {
            presentedViewController?.view.addGestureRecognizer(dismissalPanGesture)
        }
    }
    
    @objc private func panGestureHandler(_ gesture : UIPanGestureRecognizer) {
        
        guard let navigationController = navigationController else { return }
        
        let isScreenEdgePan = gesture.isKind(of: DismissalScreenEdgePanGesture.self)
        let viewTranslation = gesture.translation(in: gesture.view?.superview)
        // let viewVelocity = gesture.velocity(in: gesture.view?.superview)
        let progressX = viewTranslation.x / navigationController.view.frame.width
        let progressY = viewTranslation.y / navigationController.view.frame.height
        let progress = isScreenEdgePan ? progressX : progressY
        
        switch gesture.state {
        case .began:
            
            guard let scrollView = scrollView else {
                transitionInProgress = true
                navigationController.popViewController(animated: true)
                return
            }
            if scrollView.contentOffset.y <= 0 {
                transitionInProgress = true
                navigationController.popViewController(animated: true)
            }
            break
            
        case .changed:
            shouldCompleteTransition = progress > 0.3
            update(progress)
            break
        case .cancelled:
            transitionInProgress = false
            cancel()
            break
        case .ended:
            transitionInProgress = false
            shouldCompleteTransition ? finish() : cancel()
            break
        default:
            return
        }
    }
}

extension CiaoPushTransitionInteractor: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension CiaoPushTransitionInteractor: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
        }
    }
}
