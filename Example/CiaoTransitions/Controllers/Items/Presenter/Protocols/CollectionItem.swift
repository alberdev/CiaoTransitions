//
//  ItemsCollectionElement.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 10/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit
import CiaoTransitions

enum CollectionItem {
    case push(image: UIImage?, title: String, subtitle: String, type: CiaoTransitionStyle)
    case modal(image: UIImage?, title: String, subtitle: String, type: CiaoTransitionStyle)
}
