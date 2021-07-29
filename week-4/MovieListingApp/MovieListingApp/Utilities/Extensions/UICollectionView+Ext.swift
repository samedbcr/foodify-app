//
//  UICollectionView+Ext.swift
//  MovieListingApp
//
//  Created by Samed Biçer on 28.07.2021.
//

import UIKit

extension UICollectionView {
    func showEmptyState() {
        let emptyStateView = EmptyStateView(message: "Cannot found any movie!", image: "no_data")
        self.backgroundView = emptyStateView
    }

    func restoreFromEmptyState() {
        self.backgroundView = nil
    }
}
