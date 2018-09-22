//
//  AppStoreConfigurator.swift
//  CiaoTransitions
//
//  Created by Alberto Aznar de los Ríos on 22/9/18.
//

import UIKit

public struct CiaoAppStoreConfigurator {
    
    /// Collection view cell used to expand the view
    let fromCell: CiaoCardCollectionViewCell
    /// This is the tag asigned to your expanded view in presented view controller
    let toViewTag: Int
    
    var fromCardFrameWithoutTransform: CGRect
    var fromCardFrame: CGRect
    
    public init(fromCell: CiaoCardCollectionViewCell, toViewTag: Int) {
        self.fromCell = fromCell
        self.toViewTag = toViewTag
        
        self.fromCardFrameWithoutTransform = { () -> CGRect in
            let center = fromCell.center
            let size = fromCell.bounds.size
            let r = CGRect(
                x: center.x - size.width / 2,
                y: center.y - size.height / 2,
                width: size.width,
                height: size.height
            )
            return fromCell.superview!.convert(r, to: nil)
        }()
        
        // Prevent resize cell to original
        fromCell.enableAnimations = false
        
        if
            let currentCellFrame = fromCell.layer.presentation()?.frame, /* Get current frame on screen */
            let cardPresentationFrameOnScreen = fromCell.superview?.convert(currentCellFrame, to: nil) {
            self.fromCardFrame = cardPresentationFrameOnScreen
        } else {
            self.fromCardFrame = .zero
        }
    }
}
