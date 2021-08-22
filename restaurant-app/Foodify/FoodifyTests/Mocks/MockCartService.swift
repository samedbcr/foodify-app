//
//  MockCartService.swift
//  FoodifyTests
//
//  Created by Samed Biçer on 22.08.2021.
//

import Foundation
@testable import FoodifyAPI

final class MockCartService: CartServiceProtocol {
    var cart = [Cart]()
    var successResponse = SuccessResponse(message: "Successful!")

    func fetchCart(completion: @escaping (Result<[Cart], ErrorMessage>) -> Void) {
        completion(.success(cart))
    }

    func addToCart(product: Product, productCount: Int, completion: @escaping (Result<SuccessResponse, ErrorMessage>) -> Void) {
        completion(.success(successResponse))
    }

    func deleteCart(completion: @escaping (Result<SuccessResponse, ErrorMessage>) -> Void) {
        //
    }
}
