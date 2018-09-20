//
//  ItemCollectionViewCell.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 13/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {

    struct ViewModel {
        var title: String?
        var subtitle: String?
        var image: UIImage?
    }
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var cornerView: UIView!
    
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            fill(withViewModel: viewModel)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        itemImageView.layer.cornerRadius = 14.0
        itemImageView.clipsToBounds = true
    }
    
    private func fill(withViewModel viewModel: ViewModel) {
        itemImageView.image = viewModel.image
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
    }
}
