//
//  ResourceLoader.swift
//  FoodifyTests
//
//  Created by Samed Biçer on 22.08.2021.
//

import Foundation
import FoodifyAPI

class ResourceLoader {

    enum Resources: String {
        case categories
        case product_1
        case product_2
        case product_3
    }

    static func loadCategories(resource: Resources) throws -> [FoodifyAPI.Category] {
        let bundle = Bundle.test
        let url = bundle.url(forResource: resource.rawValue, withExtension: "json")!
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let categories = try decoder.decode([FoodifyAPI.Category].self, from: data)
        return categories
    }

    static func loadProduct(resource: Resources) throws -> Product {
        let bundle = Bundle.test
        let url = bundle.url(forResource: resource.rawValue, withExtension: "json")!
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let product = try decoder.decode(Product.self, from: data)
        return product
    }
}

private extension Bundle {
    class Dummy { }
    static let test = Bundle(for: Dummy.self)
}
