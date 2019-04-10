//
//  ModalViewController.swift
//  CiaoTransitions_Example
//
//  Created by Alberto Aznar de los Ríos on 10/04/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didSelectCancel))
    }
    
    @objc func didSelectCancel() {
        dismiss(animated: true, completion: nil)
    }
}
