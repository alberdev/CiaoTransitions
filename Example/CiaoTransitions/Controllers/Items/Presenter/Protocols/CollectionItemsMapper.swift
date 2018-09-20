//
//  CollectionItemMapper.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 11/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import Foundation

struct CollectionItemsMapper {
    
    func transform(from items: [Item]) -> [CollectionItem] {
        return items.map( transform )
    }
    
    func transform(from item: Item) -> CollectionItem {
        
        switch item {
        case let .push(image, title, subtitle, type):
            return CollectionItem.push(image: image, title: title, subtitle: subtitle, type: type)
        case let .modal(image, title, subtitle, type):
            return CollectionItem.modal(image: image, title: title, subtitle: subtitle, type: type)
        }
    }
}
