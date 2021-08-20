//
//  CartContract.swift
//  Foodify
//
//  Created by Samed Biçer on 17.08.2021.
//

import Foundation
import FoodifyAPI

protocol CartViewModelProtocol {
    var delegate: CartViewModelDelegate? { get set }
    var cart: [Cart] { get }
    var cartCount: Int { get }
    var totalPrice: Int { get }
    func load()
    func deleteAll()
    func selectProduct(at index: Int)
}

enum CartViewModelOutput {
    case setLoading(Bool)
    case reload
}

protocol CartViewModelDelegate: AnyObject {
    func handleViewOutput(_ output: CartViewModelOutput)
    func navigate(to route: ProductDetailViewController)
}
