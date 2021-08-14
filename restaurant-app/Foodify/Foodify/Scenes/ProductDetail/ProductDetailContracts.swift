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
    func load()
    func generatePropertiesUIModel() -> PropertiesStackViewUIModel?
}

enum ProductDetailViewModelOutput {
    case setLoading(Bool)
    case reload
}

protocol ProductDetailViewModelDelegate: AnyObject {
    func handleViewOutput(_ output: ProductDetailViewModelOutput)
}
