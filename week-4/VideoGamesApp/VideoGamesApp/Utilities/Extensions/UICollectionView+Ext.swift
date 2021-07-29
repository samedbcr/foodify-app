//
//  UICollectionView+Ext.swift
//  VideoGamesApp
//
//  Created by Samed Biçer on 28.07.2021.
//

import UIKit

extension UICollectionView {
    func showEmptyState() {
        let emptyStateView = EmptyStateView(message: "Cannot found any game!", image: "gaming_console")
        self.backgroundView = emptyStateView
    }

    func restoreFromEmptyState() {
        self.backgroundView = nil
    }
}
