//
//  MovieFavoriteDelegate.swift
//  MovieListingApp
//
//  Created by Samed Biçer on 26.07.2021.
//

import Foundation

protocol MovieFavoriteDelegate {
    func movieFavoriteChanged(to value: Bool, at index: Int)
}
