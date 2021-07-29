//
//  UIHelpers.swift
//  VideoGamesApp
//
//  Created by Samed Biçer on 26.07.2021.
//

import UIKit

struct UIHelper {
    static func createSingleColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.frame.width
        let padding: CGFloat = 20
        let itemSize = width - (padding * 2)

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.minimumLineSpacing = 20
        flowLayout.itemSize = CGSize(width: itemSize, height: 80) // 4:3 ratio

        return flowLayout
    }
}
