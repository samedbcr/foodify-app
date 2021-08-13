//
//  UIHelper.swift
//  Foodify
//
//  Created by Samed Biçer on 13.08.2021.
//

import UIKit

struct UIHelper {
    static func createCategoriesFlowLayout() -> UICollectionViewFlowLayout {
        let padding: CGFloat = 12

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: padding * 2, bottom: 0, right: padding * 2)
        flowLayout.minimumLineSpacing = padding
        flowLayout.estimatedItemSize = CGSize(width: 100, height: 48)

        return flowLayout
    }

    static func createTwoColumnsFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.frame.width
        let padding: CGFloat = 20
        let minimumItemSpacing: CGFloat = 20
        let availableWidth = width - (padding * 2) - minimumItemSpacing
        let itemSize = availableWidth / 2
        let imageOverflowSize = (itemSize - 40) / 2

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: imageOverflowSize + 10, left: padding, bottom: padding, right: padding)
        flowLayout.minimumLineSpacing = imageOverflowSize + 12
        flowLayout.itemSize = CGSize(width: itemSize, height: itemSize) // 1:1 ratio

        return flowLayout
    }
}

