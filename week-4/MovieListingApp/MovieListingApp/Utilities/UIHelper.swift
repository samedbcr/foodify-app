//
//  UIHelper.swift
//  MovieListingApp
//
//  Created by Samed Biçer on 22.07.2021.
//

import UIKit

struct UIHelper {
    static func createTwoColumnsFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.frame.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 20
        let availableWidth = width - (padding * 2) - minimumItemSpacing
        let itemSize = availableWidth / 2

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.minimumLineSpacing = 20
        flowLayout.itemSize = CGSize(width: itemSize, height: (itemSize * 4) / 3) // 4:3 ratio

        return flowLayout
    }
    
    static func createSingleColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.frame.width
        let padding: CGFloat = 12
        let itemSize = width - (padding * 2)

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.minimumLineSpacing = 20
        flowLayout.itemSize = CGSize(width: itemSize, height: itemSize / 2.8) // 4:3 ratio

        return flowLayout
    }
}
