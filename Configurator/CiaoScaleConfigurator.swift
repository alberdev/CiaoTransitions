//
//  ScaleConfigurator.swift
//  CiaoTransitions
//
//  Created by Alberto Aznar de los Ríos on 22/9/18.
//

import UIKit

public struct CiaoScaleConfigurator {
    
    /// Source image view is going to be scaled from your initial view controller
    public var scaleSourceImageView: UIImageView?
    
    /// Source image view frame converted to superview in view controller.
    public var scaleSourceFrame: CGRect = .zero
    
    /// This is the tag asigned to your image view in presented view controller
    public var scaleDestImageViewTag: Int = 1000000000
    
    /// Destination image view frame in presented view controller
    public var scaleDestFrame: CGRect = .zero
    
    public init() {}
}
