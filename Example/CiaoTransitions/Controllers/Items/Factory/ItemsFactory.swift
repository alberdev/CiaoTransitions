//
//  ItemsFactory.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 10/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit

struct ItemsFactory {
    
    func assembleView() -> UIViewController
    {
        let viewController = ItemsViewController()
        let routing = ItemsRouting()
        let presenter = ItemsPresenter()
        let interactor = ItemsInteractor()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.routing = routing
        presenter.interactor = interactor
        presenter.collectionProtocols = ItemsCollectionViewProtocols()
        presenter.collectionProtocols?.delegate = presenter
        interactor.output = presenter
        routing.viewController = viewController
        
        return viewController
    }
}
