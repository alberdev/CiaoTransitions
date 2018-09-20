//
//  StartedCollectionViewCell.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 10/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit

open class CiaoCardCollectionViewCell: UICollectionViewCell {
    
    /// This will make scale cell animation on touch
    var animateOnHighlight = true
    
    open var enableAnimations = true {
        didSet {
            if enableAnimations {
                animateOnHighlight = true
            } else {
                animateOnHighlight = false
                layer.removeAllAnimations()
            }
        }
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .init(width: 0, height: 4)
        layer.shadowRadius = 12
    }
    
    func resetTransform() {
        transform = .identity
    }
}

/// Setup animation handle on touch cell.
/// This make cell scale animation to simulate cell touch in App Store list.

extension CiaoCardCollectionViewCell {
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animate(highlight: true)
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        animate(highlight: false)
    }
    
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        animate(highlight: false)
    }
    
    private func animate(highlight: Bool, completion: ((Bool) -> Void)? = nil) {
        
        guard animateOnHighlight else { return }
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0,
            options: Globals.cardAllowInteractionOnHighlight ? [.allowUserInteraction] : [],
            animations: {
                self.transform = highlight ? .init(scaleX: Globals.cardScaleFactorOnHighlight, y: Globals.cardScaleFactorOnHighlight) : .identity
            }, completion: completion)
    }
}
