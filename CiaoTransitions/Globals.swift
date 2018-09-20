//
//  Globals.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 19/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit

enum Globals {
    
    /// Present animation duration
    static let presentAnimationDuration: TimeInterval = 0.8
    
    /// Dismissal animation duration
    static let dismissalAnimationDuration: TimeInterval = 0.6
    
    /// Enable or disable fade effect on presented view controller
    static let presentFadeEnabled: Bool = false
    
    /// Enable or disable fade effect on back view on present & dismiss animation
    static let backfadeEnabled: Bool = false
    
    /// Enable or disable scale effect on back view on present & dismiss animation
    static let backScaleEnabled: Bool = false
    
    /// Enable or disable lateral translation on back view on present & dismiss animation
    static let backLateralTranslationEnabled: Bool = false
    
    /// Enable or disable lateral swipe to dismiss view
    static let dragLateralEnabled: Bool = false
    
    /// Enable or disable vertical swipe to dismiss view
    static let dragDownEnabled: Bool = true
    
    /// This will select how card is expanded in the collection view (for AppStore modal transition)
    static let cardVerticalExpandingStyle: CiaoModalPresentationStyle = .fromTop
    
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
