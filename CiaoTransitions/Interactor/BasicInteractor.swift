//
//  BasicInteractor.swift
//  CiaoTransitions
//
//  Created by Alberto Aznar de los Ríos on 22/9/18.
//

import UIKit

public class BasicInteractor: Interactor {
    
    var shouldStart = true
    var updateProgress = true
    var progress: CGFloat = 0
    
    override func setupGestures() {
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
    
    public override func enableGestures() {
        dismissalPanGesture.delegate = self
        dismissalScreenEdgePanGesture.delegate = self
    }
    
    private func dismissView() {
        if isNavigationEnabled {
            navigationController?.popViewController(animated: true)
        } else {
            presentedViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func panGestureHandler(_ gesture : UIPanGestureRecognizer) {
        
        if let _ = navigationController {
            isNavigationEnabled = true
        }
        
        let isScreenEdgePan = gesture.isKind(of: DismissalScreenEdgePanGesture.self)
        let viewTranslation = gesture.translation(in: gesture.view?.superview)
        // let viewVelocity = gesture.velocity(in: gesture.view?.superview)
        
        if isNavigationEnabled {
            guard let navigationController = navigationController else { return }
            let progressX = viewTranslation.x / navigationController.view.frame.width
            let progressY = viewTranslation.y / navigationController.view.frame.height
            progress = isScreenEdgePan ? progressX : progressY
        } else {
            guard let presentedViewController = presentedViewController else { return }
            let progressX = viewTranslation.x / presentedViewController.view.frame.width
            let progressY = viewTranslation.y / presentedViewController.view.frame.height
            progress = isScreenEdgePan ? progressX : progressY
        }
        
        switch gesture.state {
        case .began:
            if updateProgress {
                transitionInProgress = true
                dismissView()
            }
            break
            
        case .changed:
            if updateProgress {
                shouldCompleteTransition = progress > 0.3
                update(progress)
            }
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
    
    public override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        updateProgress = scrollView.contentOffset.y <= 0 ? true : false
        
        if progress > 0 && transitionInProgress {
            scrollView.contentOffset.y = 0
            updateProgress = true
        }
        
        if scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
        }
    }
    
    public override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
    }
}
