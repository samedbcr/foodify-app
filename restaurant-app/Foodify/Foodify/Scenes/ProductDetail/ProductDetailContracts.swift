//
//  ProductDetailContracts.swift
//  Foodify
//
//  Created by Samed Biçer on 14.08.2021.
//

import Foundation
import FoodifyAPI

protocol ProductDetailViewModelProtocol {
    var delegate: ProductDetailViewModelDelegate? { get set }
    var product: Product? { get }
    func load(id: Int?)
    func generatePropertiesUIModel() -> PropertiesStackViewUIModel?
    func changeFavoriteStatus(id: Int?)
    func addToCart(productCount: Int)
}

enum ProductDetailViewModelOutput {
    case setLoading(Bool)
    case reload
    case showAlert
}

protocol ProductDetailViewModelDelegate: AnyObject {
    func handleViewOutput(_ output: ProductDetailViewModelOutput)
}
