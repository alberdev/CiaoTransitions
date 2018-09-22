//
//  ItemsPresenter.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 10/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit

class ItemsPresenter {
    
    weak var view: ItemsViewInterface?
    var routing: ItemsRoutingInterface?
    var interactor: ItemsInteractorInput?
    var collectionProtocols: ItemsCollectionViewProtocols?
}

extension ItemsPresenter: ItemsPresenterInterface {
    
    func viewLoaded() {
        view?.setupView()
        view?.setTitle(title: "Ciao Example")
        view?.setupCollectionView(protocols: collectionProtocols)
        interactor?.loadItems()
    }
}

extension ItemsPresenter: ItemsInteractorOutput {
    
    func didLoadItems(items: [[Item]]) {
        collectionProtocols?.items = items.map( CollectionItemsMapper().transform )
    }
}

extension ItemsPresenter: ItemsCollectionViewProtocolsDelegate {

    func collectionView(collectionView: UICollectionView, didSelectCell cell: ItemCollectionViewCell, withItem item: CollectionItem) {
        routing?.presentDetailView(cell: cell, item: item)
    }
}
