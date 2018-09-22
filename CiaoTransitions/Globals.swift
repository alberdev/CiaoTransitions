//
//  Globals.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 19/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit

enum Globals {
    
    /// Dismissal animation duration
    static let dismissalAnimationDuration: TimeInterval = 0.8
    
    /// Setup corner radius in card (for AppStore modal transition)
    static let cardCornerRadius: CGFloat = 16

    /// This will allow user to scroll while it's animated
    static let cardAllowInteractionOnHighlight = true
    
    /// Scale factor on cell animation when is highlighted
    static let cardScaleFactorOnHighlight: CGFloat = 0.95
    
    /// Without this, there'll be weird offset (probably from scrollView) that obscures
    /// the card content view of the cardDetailView.
    static let topInsetFixEnabled = true
    
    /// If true, will draw borders on animating views.
    static let debugEnabled = false
}
