//
//  CiaoTransitionProtocols.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 12/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit

protocol CiaoTransitionProtocol {
    
    /// You could use the view of view controller or the scrollview, tableview, collectionview...
    /// Its important to choose the view that is on the top of the controller, because is needed by
    /// transition controller to control gestures. This should be set once view is loaded.
    var swipedView: UIView? { get set }
}
