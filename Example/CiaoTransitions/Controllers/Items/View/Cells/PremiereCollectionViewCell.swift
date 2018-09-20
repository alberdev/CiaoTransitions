//
//  PremiereCollectionViewCell.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 10/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit

class PremiereCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var backdropImageView: UIImageView!
    
    var viewModel: PremiereCollectionViewCellVM? {
        didSet {
            guard let viewModel = viewModel else { return }
            fill(withViewModel: viewModel)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backdropImageView.layer.cornerRadius = 14.0
    }
    
    private func fill(withViewModel viewModel: PremiereCollectionViewCellVM) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        backdropImageView.image = viewModel.backdropImage
    }
}
