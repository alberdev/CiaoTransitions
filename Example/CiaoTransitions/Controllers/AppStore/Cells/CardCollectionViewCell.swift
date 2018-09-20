//
//  CardCollectionViewCell.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 18/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit
import Ciao

class CardCollectionViewCell: CiaoCardCollectionViewCell {

    @IBOutlet weak var cardContentView: CardContentView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 14.0
        contentView.clipsToBounds = true
    }
}
