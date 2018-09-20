//
//  ItemsInteractor.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 10/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit
import Ciao

class ItemsInteractor: NSObject {
    
    weak var output: ItemsInteractorOutput?
}

extension ItemsInteractor: ItemsInteractorInput {
    
    func loadItems() {
        
        let item1 = Item.push(
            image: UIImage(named: "Item1"),
            title: "Swipe down fade transition with static view",
            subtitle: "PUSH TRANSITION",
            type: CiaoTransitionType.Push.pushVertical)
        
        let item2 = Item.push(
            image: UIImage(named: "Item2"),
            title: "Swipe down fade transition with scroll view",
            subtitle: "PUSH TRANSITION",
            type: CiaoTransitionType.Push.pushVertical)
        
        let item3 = Item.push(
            image: UIImage(named: "Item3"),
            title: "Swipe lateral dismiss transition with static view",
            subtitle: "PUSH TRANSITION",
            type: CiaoTransitionType.Push.pushLateral)
        
        let item4 = Item.push(
            image: UIImage(named: "Item4"),
            title: "Scale transition & swipe down for dismiss",
            subtitle: "PUSH TRANSITION",
            type: CiaoTransitionType.Push.pushScaleImage)
        
        let item5 = Item.modal(
            image: UIImage(named: "Item5"),
            title: "App Store transition for present app details",
            subtitle: "MODAL TRANSITION",
            type: CiaoTransitionType.Modal.modalAppStore)
        
        output?.didLoadItems(items: [[item1, item2, item3, item4], [item5]])
    }
}
