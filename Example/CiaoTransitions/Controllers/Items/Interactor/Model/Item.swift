//
//  ItemType.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 11/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit
import Ciao

enum Item {
    case push(image: UIImage?, title: String, subtitle: String, type: CiaoTransitionType.Push)
    case modal(image: UIImage?, title: String, subtitle: String, type: CiaoTransitionType.Modal)
}
