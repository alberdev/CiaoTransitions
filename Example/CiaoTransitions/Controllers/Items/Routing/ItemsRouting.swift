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
}

extension ItemsRouting: ItemsRoutingInterface {
    
    func presentDetailView(cell: ItemCollectionViewCell, type: Any?, sourceRectImage: CGRect) {
        
        var presentViewController: CiaoBaseViewController?
        var params = CiaoTransition.Params()
        var scaleParams: CiaoTransition.ScaleParams? = nil
        var ciaoTransition: CiaoTransition?
        
        if let type = type as? CiaoTransitionType.Push {
            
            switch type {
            case .vertical:
                
                params.backfadeEnabled = true
                params.backScaleEnabled = true
                params.backLateralTranslationEnabled = false
                params.dragDownEnabled = true
                params.dragLateralEnabled = false
                presentViewController = cell.tag == 0 ? StaticFadeViewController() : ScrollFadeViewController()
                
            case .lateral:
                
                params.backfadeEnabled = true
                params.backScaleEnabled = false
                params.backLateralTranslationEnabled = true
                params.dragDownEnabled = false
                params.dragLateralEnabled = true
                presentViewController = LateralTranslationViewController()
                
            case .scaleImage:
                
                params.backfadeEnabled = true
                params.presentFadeEnabled = true
                params.dragDownEnabled = true
                params.dragLateralEnabled = false
                
                scaleParams = CiaoTransition.ScaleParams()
                scaleParams?.sourceImageView = cell.itemImageView
                scaleParams?.sourceFrame = sourceRectImage
                scaleParams?.destImageViewTag = 100
                scaleParams?.destFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 350)
                presentViewController = ScaleViewController()
            }
            
            ciaoTransition = CiaoTransition(pushTransitionType: type, params: params, scaleParams: scaleParams)
            presentViewController?.ciaoTransition = ciaoTransition!
        }
        
        if let type = type as? CiaoTransitionType.Modal {
            
            switch type {
            case .appStore:
            
                params.backfadeEnabled = true
                params.backScaleEnabled = false
                params.backLateralTranslationEnabled = true
                params.dragDownEnabled = false
                params.dragLateralEnabled = true
                presentViewController = AppStoreCardsViewController()
            }
            
            ciaoTransition = CiaoTransition(pushTransitionType: CiaoTransitionType.Push.lateral, params: params, scaleParams: scaleParams)
            presentViewController?.ciaoTransition = ciaoTransition!
        }

        if let presentViewController = presentViewController {
            viewController?.navigationController?.delegate = ciaoTransition
            viewController?.navigationController?.pushViewController(presentViewController, animated: true)
        }
    }
}


