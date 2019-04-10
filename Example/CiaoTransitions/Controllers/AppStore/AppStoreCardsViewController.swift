//
//  AppStoreViewController.swift
//  CiaoExample
//
//  Created by Alberto Aznar de los Ríos on 14/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit
import CiaoTransitions

class AppStoreCardsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var ciaoTransition: CiaoTransition?
    
    var cards = [[
        CardContentView.ViewModel(image: UIImage(named: "Image1"), title: "Best latest\nphotos sample 1", subtitle: "FEATURED IMAGES"),
        CardContentView.ViewModel(image: UIImage(named: "Image2"), title: "Best latest\nphotos sample 2", subtitle: "FEATURED IMAGES"),
        CardContentView.ViewModel(image: UIImage(named: "Image3"), title: "Best latest\nphotos sample 3", subtitle: "FEATURED IMAGES")]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //ciaoTransition?.scrollView = collectionView
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 20
            layout.minimumInteritemSpacing = 0
            layout.sectionInset = .init(top: 20, left: 0, bottom: 64, right: 0)
        }
        
        // Make it responds to highlight state faster
        collectionView.delaysContentTouches = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.clipsToBounds = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        collectionView.contentInsetAdjustmentBehavior = .never
        
        CardCollectionViewCell.register(nibFor: collectionView)
        TodayHeaderReusableView.register(nibFor: collectionView, kind: UICollectionView.elementKindSectionHeader)
    }
}

extension AppStoreCardsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CardCollectionViewCell.reuse(collectionView, indexPath: indexPath) as! CardCollectionViewCell
        cell.cardContentView.viewModel = cards[indexPath.section][indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .phone {
            
            let cardHorizontalOffset: CGFloat = 20
            let cardHeightByWidthRatio: CGFloat = 1.0
            let width = collectionView.bounds.size.width - 2 * cardHorizontalOffset
            let height: CGFloat = width * cardHeightByWidthRatio
            return CGSize(width: width, height: height)
            //return CGSize(width: collectionView.bounds.width, height: 350)
            
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
            
            return CGSize(width: width, height: 350)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: TodayHeaderReusableView.viewHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = TodayHeaderReusableView.reuse(collectionView, indexPath: indexPath, kind: kind) as! TodayHeaderReusableView
        header.shouldShowProfileImageView = (indexPath.section == 0)
        header.viewModel = TodayHeaderReusableView.ViewModel(title: "Today", subtitle: "APPSTORE CARDS TRANSITION", image: UIImage(named: "Profile"))
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? CiaoCardCollectionViewCell else { return }
        let presentViewController = AppStoreCardDetailViewController()
        presentViewController.viewModel = cards[indexPath.section][indexPath.row]
        
        var configurator = CiaoConfigurator()
        configurator.dragDownEnabled = true
        configurator.dragLateralEnabled = false
        
        let appStoreConfigurator = CiaoAppStoreConfigurator(fromCell: cell, toViewTag: 100)
        
        let transition = CiaoTransition(style: .appStore, configurator: configurator, appStoreConfigurator: appStoreConfigurator)
        
        presentViewController.ciaoTransition = transition
        presentViewController.transitioningDelegate = transition
//
//        // If `modalPresentationStyle` is not `.fullScreen`, this should be set to true
//        // to make status bar depends on presented vc.
        presentViewController.modalPresentationCapturesStatusBarAppearance = true
        presentViewController.modalPresentationStyle = .custom
        present(presentViewController, animated: true, completion: nil)
    }
}
    
extension AppStoreCardsViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        ciaoTransition?.didScroll(scrollView)
    }
}

