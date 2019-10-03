//
//  ItemsRouting.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 10/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit
import CiaoTransitions

class ItemsRouting: NSObject {
    var viewController: UIViewController?
    var transition: CiaoTransition?
}

extension ItemsRouting: ItemsRoutingInterface {
    
    func presentDetailView(cell: ItemCollectionViewCell, item: CollectionItem) {
        
        var style = CiaoTransitionStyle.vertical
        switch item {
        case let .push(_, _, _, type): style = type
        case let .modal(_, _, _, type): style = type
        }
        
        var presentViewController: UIViewController?
        var configurator = CiaoConfigurator()
        var scaleConfigurator: CiaoScaleConfigurator?
        
        switch style {
        case .vertical:
            
            configurator.dragDownEnabled = true
            configurator.dragLateralEnabled = false
            presentViewController = cell.tag == 0 ? StaticFadeViewController() : ScrollFadeViewController()
            
        case .lateral:
            
            configurator.lateralTranslationEnabled = true
            configurator.dragDownEnabled = false
            configurator.dragLateralEnabled = true
            presentViewController = LateralTranslationViewController()
            
        case .scaleImage:
            
            configurator.dragDownEnabled = true
            configurator.dragLateralEnabled = false
            configurator.fadeInEnabled = true
            configurator.fadeOutEnabled = false
            configurator.scale3D = false
            
            let rectInCell = cell.cornerView.convert(cell.itemImageView.frame, to: cell)
            let rectInView = cell.convert(rectInCell, to: viewController?.view)

            scaleConfigurator = CiaoScaleConfigurator()
            scaleConfigurator?.scaleSourceImageView = cell.itemImageView
            scaleConfigurator?.scaleSourceFrame = rectInView
            scaleConfigurator?.scaleDestImageViewTag = 100
            scaleConfigurator?.scaleDestFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 350)
            presentViewController = ScaleViewController()
            
        case .appStore:
            
            configurator.lateralTranslationEnabled = true
            configurator.dragDownEnabled = true
            configurator.dragLateralEnabled = false
            presentViewController = AppStoreCardsViewController()
        }
        
        if style == .appStore {
            style = .vertical
        }
        transition = CiaoTransition(style: style, configurator: configurator, scaleConfigurator: scaleConfigurator)
        
        if let presentViewController = presentViewController as? ScrollFadeViewController {
            presentViewController.ciaoTransition = transition
        }
        if let presentViewController = presentViewController as? AppStoreCardsViewController {
            presentViewController.ciaoTransition = transition
        }
        presentViewController?.transitioningDelegate = transition
        
//        switch item {
//        case .push:
//            viewController?.navigationController?.delegate = transition
//            viewController?.navigationController?.pushViewController(presentViewController!, animated: true)
//        case .modal:
        presentViewController?.modalPresentationStyle = .fullScreen
            viewController?.present(presentViewController!, animated: true, completion: nil)
//        }
        
        
    }
}


