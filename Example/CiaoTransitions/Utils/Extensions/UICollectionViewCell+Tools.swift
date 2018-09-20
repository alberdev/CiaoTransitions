//
//  UICollectionViewCell+Tools.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 10/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit

public extension UICollectionViewCell {
    
    public static var uniqueIdentifier: String {
        return String(describing: self)
    }
    
    public var uniqueIdentifier: String {
        return type(of: self).uniqueIdentifier
    }
    
    public static var hasNib: Bool {
        return Bundle.main.path(forResource: self.uniqueIdentifier, ofType: "nib") != nil
    }
    
    public static var nib: UINib {
        return UINib(nibName: self.uniqueIdentifier, bundle: nil)
    }
    
    // MARK: - cells
    
    public static func register(nibFor collectionView: UICollectionView) {
        collectionView.register(self.nib, forCellWithReuseIdentifier: self.uniqueIdentifier)
    }
    
    public static func register(classFor collectionView: UICollectionView) {
        collectionView.register(self, forCellWithReuseIdentifier: self.uniqueIdentifier)
    }
    
    public static func register(itemFor collectionView: UICollectionView) {
        if self.hasNib {
            return self.register(nibFor: collectionView)
        }
        self.register(classFor: collectionView)
    }
    
    public static func reuse(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: self.uniqueIdentifier, for: indexPath)
    }
    
    // MARK: - supplementary views
    
    public static func register(nibFor collectionView: UICollectionView, kind: String) {
        collectionView.register(self.nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: self.uniqueIdentifier)
    }
    
    public static func register(classFor collectionView: UICollectionView, kind: String) {
        collectionView.register(self, forSupplementaryViewOfKind: kind, withReuseIdentifier: self.uniqueIdentifier)
    }
    
    public static func register(itemFor collectionView: UICollectionView, kind: String) {
        if self.hasNib {
            return self.register(nibFor: collectionView, kind: kind)
        }
        self.register(classFor: collectionView, kind: kind)
    }
    
    public static func reuse(_ collectionView: UICollectionView, indexPath: IndexPath, kind: String) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.uniqueIdentifier, for: indexPath)
    }
}
