//
//  UICollectionView+Ext.swift
//  Foodify
//
//  Created by Samed Biçer on 21.08.2021.
//

import UIKit

extension UICollectionView {
    func showEmptyState(message: String, image: String) {
        let emptyStateView = MainEmptyStateView(message: message, image: image)
        self.backgroundView = emptyStateView
    }

    func restoreFromEmptyState() {
        self.backgroundView = nil
    }
}
