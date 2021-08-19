//
//  HomeContracts.swift
//  Foodify
//
//  Created by Samed Biçer on 12.08.2021.
//

import Foundation
import FoodifyAPI

protocol HomeViewModelProtocol {
    var delegate: HomeViewModelDelegate? { get set }
    var categories: [FoodifyAPI.Category] { get }
    var products: [Product] { get }
    var categoriesCount: Int { get }
    var productsCount: Int { get }
    func loadCategories()
    func loadProducts()
    func selectCategory(at index: Int)
    func selectProduct(at index: Int)
}

enum HomeViewModelOutput {
    case setLoading(Bool)
    case reloadCategoryList
    case reloadProductList
}

protocol HomeViewModelDelegate: AnyObject {
    func handleViewOutput(_ output: HomeViewModelOutput)
    func navigate(to route: ProductDetailViewController)
}
