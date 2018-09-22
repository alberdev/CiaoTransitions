//
//  Interactor.swift
//  CiaoTransitions
//
//  Created by Alberto Aznar de los Ríos on 21/9/18.
//

import UIKit

public class Interactor: UIPercentDrivenInteractiveTransition {
    
    struct Params {
        var dragLateralEnabled = true
        var dragDownEnabled = true
    }
    
    var navigationController: UINavigationController?
    var presentedViewController: UIViewController? {
        didSet {
            setupGestures()
        }
    }
    var params: Params
    
    var transitionInProgress = false
    var shouldCompleteTransition = false
    var isNavigationEnabled = false
    
    
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
    
    init(params: Params) {
        self.params = params
        super.init()
        self.completionCurve = .linear
    }
    
    func setupGestures() {
        
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
    }
}

extension Interactor: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
