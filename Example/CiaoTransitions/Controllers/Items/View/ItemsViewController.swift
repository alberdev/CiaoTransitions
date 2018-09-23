//
//  ItemsViewController.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 10/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: ItemsPresenterInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewLoaded()
    }
}

extension ItemsViewController: ItemsViewInterface {
    
    func setTitle(title: String) {
        self.title = title
    }
    
    func setupView() {
        
    }
    
    func setupCollectionView(protocols: ItemsCollectionViewProtocols?) {
        
        ItemCollectionViewCell.register(nibFor: collectionView)
        TodayHeaderReusableView.register(nibFor: collectionView, kind: UICollectionView.elementKindSectionHeader)
        
        collectionView.dataSource = protocols
        collectionView.delegate = protocols
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
    
}
