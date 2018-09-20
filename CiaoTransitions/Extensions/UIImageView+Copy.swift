//
//  UIImageView+Copy.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 13/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func clone() -> UIImageView{
        
        let locationOfCloneImageView = CGPoint(x: 0, y: 0)
        //x and y coordinates of where you want your image. (More specifically, the x and y coordinated of where you want the CENTER of your image to be)
        let cloneImageView = UIImageView(image: self.image)
        cloneImageView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        //same size as old image view
        cloneImageView.alpha = self.alpha
        //same view opacity
        cloneImageView.layer.opacity = self.layer.opacity
        //same view corner radius
        cloneImageView.layer.cornerRadius = self.layer.cornerRadius
        //same view border color
        cloneImageView.layer.borderColor = self.layer.borderColor
        //same view border width
        cloneImageView.layer.borderWidth = self.layer.borderWidth
        //same layer opacity
        cloneImageView.clipsToBounds = self.clipsToBounds
        //same clipping settings
        cloneImageView.backgroundColor = self.backgroundColor
        //same BG color
        if let aColor = self.tintColor {
            self.tintColor = aColor
        }
        //matches tint color.
        cloneImageView.contentMode = self.contentMode
        //matches up things like aspectFill and stuff.
        cloneImageView.isHighlighted = self.isHighlighted
        //matches whether it's highlighted or not
        cloneImageView.isOpaque = self.isOpaque
        //matches can-be-opaque BOOL
        cloneImageView.isUserInteractionEnabled = self.isUserInteractionEnabled
        //touches are detected or not
        cloneImageView.isMultipleTouchEnabled = self.isMultipleTouchEnabled
        //multi-touches are detected or not
        cloneImageView.autoresizesSubviews = self.autoresizesSubviews
        //matches whether or not subviews resize upon bounds change of image view.
        //cloneImageView.hidden = originalImageView.hidden;//commented out because you probably never need this one haha... But if the first one is hidden, so is this clone (if uncommented)
        cloneImageView.layer.zPosition = self.layer.zPosition + 1
        //places it above other views in the parent view and above the original image. You can also just use `insertSubview: aboveSubview:` in code below to achieve this.
        self.superview?.addSubview(cloneImageView)
        //adds this image view to the same parent view that the other image view is in.
        cloneImageView.center = locationOfCloneImageView
        //set at start of code.
        
        return cloneImageView
    }
}
