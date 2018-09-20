//
//  ItemsViewInterface.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 10/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import Foundation

protocol ItemsViewInterface: class {
    func setTitle(title: String)
    func setupCollectionView(protocols: ItemsCollectionViewProtocols?)
    func setupView()
}
