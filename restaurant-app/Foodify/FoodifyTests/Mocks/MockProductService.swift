//
//  MockProductService.swift
//  FoodifyTests
//
//  Created by Samed Biçer on 22.08.2021.
//

import Foundation
@testable import FoodifyAPI

final class MockProductService: ProductServiceProtocol {
    var products = [Product]()
    var product: Product!

    func fetchProducts(with categoryIds: [Int], completion: @escaping (Result<[Product], ErrorMessage>) -> Void) {
        completion(.success(products))
    }

    func fetchProduct(with id: Int, completion: @escaping (Result<Product, ErrorMessage>) -> Void) {
        completion(.success(product))
    }


}
