//
//  DetailViewController.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 11/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit
import Ciao

class ScrollFadeViewController: CiaoBaseViewController {
 
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ciaoTransition?.scrollView = scrollView
    }
}



