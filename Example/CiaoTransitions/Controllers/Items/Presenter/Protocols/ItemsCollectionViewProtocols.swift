//
//  ItemsCollectionViewProtocols.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 10/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit

protocol ItemsCollectionViewProtocolsDelegate: class {
    func collectionView(collectionView: UICollectionView, didSelectCell cell: ItemCollectionViewCell, withItem item: CollectionItem)
}

class ItemsCollectionViewProtocols : NSObject {
    
    weak var delegate: ItemsCollectionViewProtocolsDelegate?
    var items = [[CollectionItem]]()
}

extension ItemsCollectionViewProtocols: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = items[indexPath.section][indexPath.row]
        
        switch item {
        case let .push(image, title, subtitle, _):
            let cell = ItemCollectionViewCell.reuse(collectionView, indexPath: indexPath) as! ItemCollectionViewCell
            cell.viewModel = ItemCollectionViewCell.ViewModel(title: title, subtitle: subtitle, image: image)
            cell.tag = indexPath.row
            return cell
        case let .modal(image, title, subtitle, _):
            let cell = ItemCollectionViewCell.reuse(collectionView, indexPath: indexPath) as! ItemCollectionViewCell
            cell.viewModel = ItemCollectionViewCell.ViewModel(title: title, subtitle: subtitle, image: image)
            cell.tag = indexPath.row
            return cell
        }
    }
}

extension ItemsCollectionViewProtocols: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return CGSize(width: collectionView.bounds.width, height: 85.0)
        } else {
            
            // Number of Items per Row
            let numberOfItemsInRow = 2
            
            // Current Row Number
            let rowNumber = indexPath.item/numberOfItemsInRow
            
            // Compressed With
            let compressedWidth = collectionView.bounds.width/3
            
            // Expanded Width
            let expandedWidth = (collectionView.bounds.width/3) * 2
            
            // Is Even Row
            let isEvenRow = rowNumber % 2 == 0
            
            // Is First Item in Row
            let isFirstItem = indexPath.item % numberOfItemsInRow != 0
            
            // Calculate Width
            var width: CGFloat = 0.0
            if isEvenRow {
                width = isFirstItem ? compressedWidth : expandedWidth
            } else {
                width = isFirstItem ? expandedWidth : compressedWidth
            }
            
            return CGSize(width: width, height: 85.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: TodayHeaderReusableView.viewHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = TodayHeaderReusableView.reuse(collectionView, indexPath: indexPath, kind: kind) as! TodayHeaderReusableView
        header.shouldShowProfileImageView = (indexPath.section == 0)
        switch indexPath.section {
        case 0: header.viewModel = TodayHeaderReusableView.ViewModel(title: "Basic Transitions", subtitle: "", image: nil)
        case 1: header.viewModel = TodayHeaderReusableView.ViewModel(title: "Special Transitions", subtitle: "", image: nil)
        default: break
        }
        return header
    }
}

extension ItemsCollectionViewProtocols: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? ItemCollectionViewCell {
            let item = items[indexPath.section][indexPath.row]
            delegate?.collectionView(collectionView: collectionView, didSelectCell: cell, withItem: item)
        }
    }
}
