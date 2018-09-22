//
//  ItemsInteractor.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 10/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit
import CiaoTransitions

class ItemsInteractor: NSObject {
    
    weak var output: ItemsInteractorOutput?
}

extension ItemsInteractor: ItemsInteractorInput {
    
    func loadItems() {
        
        let item1 = Item.push(
            image: UIImage(named: "Item1"),
            title: "Swipe down fade transition with static view",
            subtitle: "BASIC TRANSITION",
            type: .vertical)
        
        let item2 = Item.push(
            image: UIImage(named: "Item2"),
            title: "Swipe down fade transition with scroll view",
            subtitle: "BASIC TRANSITION",
            type: .vertical)
        
        let item3 = Item.push(
            image: UIImage(named: "Item3"),
            title: "Swipe lateral dismiss transition with static view",
            subtitle: "BASIC TRANSITION",
            type: .lateral)
        
        let item4 = Item.push(
            image: UIImage(named: "Item4"),
            title: "Scale transition & swipe down for dismiss",
            subtitle: "BASIC TRANSITION",
            type: .scaleImage)
        
        let item5 = Item.push(
            image: UIImage(named: "Item5"),
            title: "App Store transition for present app details",
            subtitle: "SPECIAL TRANSITION",
            type: .appStore)
        
        output?.didLoadItems(items: [[item1, item2, item3, item4], [item5]])
    }
}
