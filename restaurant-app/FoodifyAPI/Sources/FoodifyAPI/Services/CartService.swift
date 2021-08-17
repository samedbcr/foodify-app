//
//  CartService.swift
//
//
//  Created by Samed Biçer on 17.08.2021.
//

import Foundation

public protocol CartServiceProtocol {
    func fetchCart(completion: @escaping (Result<[Cart], Error>) -> Void)
}

public class CartService: CartServiceProtocol {

    let mockCart: [Cart] = [
        Cart(id: 1, product_id: 2, isDeleted: false, count: 2, productName: "Test Product", imagePath: "chicken_plate", price: 25, categoryName: "Meat"),
        Cart(id: 2, product_id: 3, isDeleted: false, count: 1, productName: "Another Product", imagePath: "salad_plate", price: 18, categoryName: "Salad"),
        Cart(id: 3, product_id: 4, isDeleted: false, count: 3, productName: "Chicken Meat", imagePath: "chicken_meat_plate", price: 12, categoryName: "Chicken"),
        Cart(id: 5, product_id: 12, isDeleted: false, count: 2, productName: "Testy Product", imagePath: "chicken_plate", price: 28, categoryName: "Meat"),
        Cart(id: 6, product_id: 13, isDeleted: false, count: 1, productName: "Anothe Product", imagePath: "salad_plate", price: 18, categoryName: "Salad"),
        Cart(id: 7, product_id: 14, isDeleted: false, count: 3, productName: "Chi Meat", imagePath: "chicken_meat_plate", price: 12, categoryName: "Chicken")
    ]

    public init() { }

    public func fetchCart(completion: @escaping (Result<[Cart], Error>) -> Void) {
        completion(.success(mockCart))
    }
}
