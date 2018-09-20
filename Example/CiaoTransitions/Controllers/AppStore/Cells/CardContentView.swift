//
//  CardContentView.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 16/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit

@IBDesignable class CardContentView: UIView {
    
    struct ViewModel {
        var image: UIImage?
        var title: String?
        var subtitle: String?
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var backdropImageView: UIImageView!
    
    @IBOutlet weak var leftImageConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightImageConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomImageConstraint: NSLayoutConstraint!
    @IBOutlet weak var topImageConstraint: NSLayoutConstraint!
    
    @IBInspectable var backgroundImage: UIImage? {
        get {
            return self.backdropImageView.image
        }
        set(image) {
            self.backdropImageView.image = image
        }
    }
    
    var viewModel: ViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        _ = fromNib()
        
        // This will make the background image stays still at the center while we animating
        backdropImageView.contentMode = .center
    }
    
    private func fill(withViewModel viewModel: ViewModel) {
        backdropImageView.image = viewModel.image
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
    }
    
    override func awakeFromNib() {
        guard let viewModel = viewModel else { return }
        fill(withViewModel: viewModel)
    }
}
