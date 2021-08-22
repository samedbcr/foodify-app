//
//  Product.swift
//
//
//  Created by Samed Biçer on 13.08.2021.
//

import Foundation

public struct Product: Codable {
    public let id: Int
    public let imagePath: String
    public let name: String
    public let description: String
    public let price: Double
    public let ratingCount: Int
    public let ingredients: [Ingredient]
    public let isFavorited: Bool
}

public struct Ingredient: Codable {
    public let name: String
    public let imagePath: String
    public let value: Double
}
