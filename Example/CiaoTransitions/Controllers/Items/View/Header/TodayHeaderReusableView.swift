//
//  TodayHeaderReusableView.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 10/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit

class TodayHeaderReusableView: UICollectionViewCell {

    struct ViewModel {
        var title: String?
        var subtitle: String?
        var image: UIImage?
    }
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    static let viewHeight: CGFloat = 81
    
    var shouldShowProfileImageView: Bool = true {
        didSet {
            profileImageView.isHidden = !shouldShowProfileImageView
        }
    }
    
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            fill(withViewModel: viewModel)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.cornerRadius = profileImageView.bounds.width/2
        profileImageView.layer.borderWidth = 0.5
        profileImageView.layer.borderColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0).cgColor
    }
    
    private func fill(withViewModel viewModel: ViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        profileImageView.image = viewModel.image
    }
}
