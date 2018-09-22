//
//  DetailViewController.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 11/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit
import CiaoTransitions

class ScrollFadeViewController: UIViewController {
 
    @IBOutlet weak var scrollView: UIScrollView!
    var ciaoTransition: CiaoTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = ciaoTransition
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        transition?.didScroll(scrollView: scrollView)
//    }
}



