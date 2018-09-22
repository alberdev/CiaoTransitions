//
//  Configurator.swift
//  CiaoTransitions
//
//  Created by Alberto Aznar de los Ríos on 22/9/18.
//

import Foundation

public struct CiaoConfigurator {
    
    /// Present animation duration
    public var duration: TimeInterval = 0.8
    
    /// This block is executed when the view has been presented
    public var presentCompletion: (()->Void)? = nil
    
    /// This block is executed when the view has been dismissed
    public var dismissCompletion: (()->Void)? = nil
    
    /// Enable or disable fade effect on main view controller
    public var fadeOutEnabled = true
    
    /// Enable or disable fade effect on presented view controller
    public var fadeInEnabled = false
    
    /// Enable or disable scale 3d effect on back main view controller
    public var scale3D = true
    
    /// Enable or disable lateral translation on main view controller
    public var lateralTranslationEnabled = false
    
    /// Enable or disable lateral swipe to dismiss view
    public var dragLateralEnabled = false
    
    /// Enable or disable vertical swipe to dismiss view
    public var dragDownEnabled = true
    
    public init() {}
}
