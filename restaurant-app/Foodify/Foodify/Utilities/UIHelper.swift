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
}

