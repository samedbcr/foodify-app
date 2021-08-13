//
//  ProductService.swift
//
//
//  Created by Samed Biçer on 13.08.2021.
//

import Foundation

public protocol ProductServiceProtocol {
    func fetchProducts(complation: @escaping (Result<[Product], Error>) -> Void)
}

public class ProductService: ProductServiceProtocol {

    let mockProducts: [Product] = [
        Product(imagePath: "chicken_meat_plate", name: "Chicken Meal", price: 24, ratingCount: 4),
        Product(imagePath: "chicken_plate", name: "Chicken Plate", price: 22, ratingCount: 3),
        Product(imagePath: "salad_plate", name: "Salad Plate Exclusive", price: 18, ratingCount: 5),
        Product(imagePath: "hamburger", name: "Hamburger Menu", price: 12, ratingCount: 3),
        Product(imagePath: "chicken_plate", name: "Chicken Exclusive", price: 26, ratingCount: 5),
        Product(imagePath: "salad_plate", name: "Chicken Salad", price: 10, ratingCount: 2),
        Product(imagePath: "chicken_meat_plate", name: "Meal", price: 20, ratingCount: 4),
        Product(imagePath: "chicken_plate", name: "Chicken", price: 14, ratingCount: 4)
    ]

    public init() { }

    public func fetchProducts(complation: @escaping ((Result<[Product], Error>) -> Void)) {
        complation(.success(mockProducts))
    }
}
