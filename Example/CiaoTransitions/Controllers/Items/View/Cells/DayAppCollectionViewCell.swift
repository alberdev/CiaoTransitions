//
//  DayAppCollectionViewCell.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 10/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit

class DayAppCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet weak var appIconImageView: UIImageView!
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var appDescriptionLabel: UILabel!
    @IBOutlet weak var getButtonView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    var viewModel: DayAppCollectionViewCellVM? {
        didSet {
            guard let viewModel = viewModel else { return }
            fill(withViewModel: viewModel)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        appIconImageView.layer.cornerRadius = 14.0
        containerView.layer.cornerRadius = 14.0
        getButtonView.layer.cornerRadius = getButtonView.bounds.height/2
    }

    private func fill(withViewModel viewModel: DayAppCollectionViewCellVM) {
        backdropImageView.image = viewModel.backdropImage
        appIconImageView.image = viewModel.appIcon
        appNameLabel.text = viewModel.appName
        appDescriptionLabel.text = viewModel.appDescription
    }
}
