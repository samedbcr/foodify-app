//
//  ProductService.swift
//
//
//  Created by Samed Biçer on 13.08.2021.
//

import Foundation
import Alamofire

public protocol ProductServiceProtocol {
    func fetchProducts(with categoryIds: [Int], completion: @escaping (Result<[Product], ErrorMessage>) -> Void)
    func fetchProduct(with id: Int, completion: @escaping (Result <Product, ErrorMessage>) -> Void)
}

public class ProductService: ProductServiceProtocol {
    let baseURL = "https://app-foodify.herokuapp.com/products"

//    static let mockIngredients: [Ingredient] = {
//        let ingredient1 = Ingredient(name: "Protein", imagePath: "strawberry", value: 52)
//        let ingredient2 = Ingredient(name: "Fat", imagePath: "pizza", value: 42)
//        let ingredient3 = Ingredient(name: "Carb", imagePath: "hamburger", value: 24)
//        let ingredients = [ingredient1, ingredient2, ingredient3]
//        return ingredients
//    }()

    var mockProducts: [Product] = []

    public init() {
//        mockProducts = [
//            Product(id: 1, imagePath: "chicken_meat_plate", name: "Chicken Meal", description: "Test Description, this is an amazin meal that made in Turkey. Test test", price: 24, ratingCount: 4, ingredients: Self.mockIngredients),
//            Product(id: 2, imagePath: "chicken_plate", name: "Chicken Plate", description: "Test Description, this is an amazin meal that made in Turkey. Test test", price: 22, ratingCount: 3, ingredients: Self.mockIngredients),
//            Product(id: 3, imagePath: "salad_plate", name: "Salad Plate Exclusive", description: "Test Description, this is an amazin meal that made in Turkey. Test test", price: 18, ratingCount: 5, ingredients: Self.mockIngredients),
//            Product(id: 4, imagePath: "hamburger", name: "Hamburger Menu", description: "Test Description, this is an amazin meal that made in Turkey. Test test", price: 12, ratingCount: 3, ingredients: Self.mockIngredients),
//            Product(id: 5, imagePath: "chicken_plate", name: "Chicken Exclusive", description: "Test Description, this is an amazin meal that made in Turkey. Test test", price: 26, ratingCount: 5, ingredients: Self.mockIngredients),
//            Product(id: 6, imagePath: "salad_plate", name: "Chicken Salad", description: "Test Description, this is an amazin meal that made in Turkey. Test test", price: 10, ratingCount: 2, ingredients: Self.mockIngredients),
//            Product(id: 7, imagePath: "chicken_meat_plate", name: "Meal", description: "Test Description, this is an amazin meal that made in Turkey. Test test", price: 20, ratingCount: 4, ingredients: Self.mockIngredients),
//            Product(id: 8, imagePath: "chicken_plate", name: "Chicken", description: "Test Description, this is an amazin meal that made in Turkey. Test test", price: 14, ratingCount: 4, ingredients: Self.mockIngredients)
//        ]
    }

    public func fetchProducts(with categoryIds: [Int], completion: @escaping (Result<[Product], ErrorMessage>) -> Void) {
        let parameters = ["category_id": categoryIds]
        let encoder: ParameterEncoder = URLEncodedFormParameterEncoder(encoder: URLEncodedFormEncoder(arrayEncoding: .noBrackets))
        guard let url = URL(string: baseURL) else {
            completion(.failure(.invalidURL))
            return
        }

        AF.request(url, parameters: parameters, encoder: encoder).responseData { response in
            switch response.result {
            case .failure(let error):
                print(error)
                completion(.failure(.invalidResponse))
                return
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let products = try decoder.decode([Product].self, from: data)
                    completion(.success(products))
                } catch {
                    completion(.failure(.invalidData))
                }
            }
        }
    }

    public func fetchProduct(with id: Int, completion: @escaping (Result <Product, ErrorMessage>) -> Void) {
        let endPoint = "\(baseURL)/\(id)"

        guard let url = URL(string: endPoint) else {
            completion(.failure(.invalidURL))
            return
        }

        AF.request(url).responseData { response in
            switch response.result {
            case .failure(let error):
                print(error)
                completion(.failure(.invalidResponse))
                return
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let product = try decoder.decode(Product.self, from: data)
                    completion(.success(product))
                } catch {
                    completion(.failure(.invalidData))
                }
            }
        }
    }
}
