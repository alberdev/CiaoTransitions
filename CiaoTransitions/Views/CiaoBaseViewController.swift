//
//  BaseViewController.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 13/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit

open class CiaoBaseViewController: UIViewController {
    
    open var ciaoTransition: CiaoTransition?
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.clipsToBounds = true
    }
}
