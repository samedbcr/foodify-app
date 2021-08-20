//
//  FavoritesContracts.swift
//  Foodify
//
//  Created by Samed Biçer on 18.08.2021.
//

import Foundation
import FoodifyAPI

protocol FavoritesViewModelProtocol {
    var delegate: FavoritesViewModelDelegate? { get set }
    var products: [Product] { get }
    var productsCount: Int { get }
    func load()
    func selectProduct(at index: Int)
}

enum FavoritesViewModelOutput {
    case setLoading(Bool)
    case reload
}

protocol FavoritesViewModelDelegate: AnyObject {
    func handleOutput(_ output: FavoritesViewModelOutput)
    func navigate(to route: ProductDetailViewController)
}
