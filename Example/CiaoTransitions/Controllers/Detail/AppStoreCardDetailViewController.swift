//
//  AppStoreViewController.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 14/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit
import CiaoTransitions

class AppStoreCardDetailViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cardContentView: CardContentView!
    @IBOutlet weak var button: UIButton!
    
    var viewModel: CardContentView.ViewModel?
    var ciaoTransition: CiaoTransition?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.clipsToBounds = true
        cardContentView.viewModel = viewModel
        scrollView.delegate = self
        button.layer.cornerRadius = 18
    }
    
    @IBAction func didSelectBuyButton(_ sender: UIButton) {
        let vc = ModalViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overCurrentContext
        nav.navigationBar.isTranslucent = true
        present(nav, animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        ciaoTransition?.didScroll(scrollView)
    }
}
