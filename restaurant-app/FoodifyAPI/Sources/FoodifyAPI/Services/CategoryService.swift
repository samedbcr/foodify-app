//
//  CategoryService.swift
//
//
//  Created by Samed Biçer on 12.08.2021.
//

import Foundation

public protocol CategoryServiceProtocol {
    func fetchCategories(completion: @escaping (Result<[Category], Error>) -> Void)
}

public class CategoryService: CategoryServiceProtocol {

    let mockCategories: [Category] = [
        Category(imagePath: "strawberry", name: "Dessert"),
        Category(imagePath: "pizza", name: "Pizza"),
        Category(imagePath: "hamburger", name: "Hamburger"),
        Category(imagePath: "strawberry", name: "Fruit")
    ]

    public init() { }

    public func fetchCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
        completion(.success(mockCategories))
    }
}
