//
//  CartService.swift
//
//
//  Created by Samed Biçer on 17.08.2021.
//

import Foundation
import Alamofire

public protocol CartServiceProtocol {
    func fetchCart(completion: @escaping (Result<[Cart], ErrorMessage>) -> Void)
    func addToCart(product: Product, productCount: Int, completion: @escaping (Result<SuccessResponse, ErrorMessage>) -> Void)
}

public class CartService: CartServiceProtocol {
    let baseURL = "https://app-foodify.herokuapp.com/cart/"

//    let mockCart: [Cart] = [
//        Cart(id: 1, product_id: 2, isDeleted: false, count: 2, productName: "Test Product", imagePath: "chicken_plate", price: 25, categoryName: "Meat"),
//        Cart(id: 2, product_id: 3, isDeleted: false, count: 1, productName: "Another Product", imagePath: "salad_plate", price: 18, categoryName: "Salad"),
//        Cart(id: 3, product_id: 4, isDeleted: false, count: 3, productName: "Chicken Meat", imagePath: "chicken_meat_plate", price: 12, categoryName: "Chicken"),
//        Cart(id: 5, product_id: 12, isDeleted: false, count: 2, productName: "Testy Product", imagePath: "chicken_plate", price: 28, categoryName: "Meat"),
//        Cart(id: 6, product_id: 13, isDeleted: false, count: 1, productName: "Anothe Product", imagePath: "salad_plate", price: 18, categoryName: "Salad"),
//        Cart(id: 7, product_id: 14, isDeleted: false, count: 3, productName: "Chi Meat", imagePath: "chicken_meat_plate", price: 12, categoryName: "Chicken")
//    ]

    public init() { }

    public func fetchCart(completion: @escaping (Result<[Cart], ErrorMessage>) -> Void) {
        guard let url = URL(string: baseURL) else {
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
                    let cart = try decoder.decode([Cart].self, from: data)
                    completion(.success(cart))
                } catch {
                    completion(.failure(.invalidData))
                }
            }
        }
    }

    public func addToCart(product: Product, productCount: Int, completion: @escaping (Result<SuccessResponse, ErrorMessage>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(.failure(.invalidURL))
            return
        }

        let parameters = [
            "id": product.id,
            "count": productCount
        ]

        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default).responseData { response in
            switch response.result {
            case .failure(let error):
                print(error)
                completion(.failure(.invalidResponse))
                return
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let successResponse = try decoder.decode(SuccessResponse.self, from: data)
                    completion(.success(successResponse))
                } catch {
                    completion(.failure(.invalidData))
                }
            }
        }

//        do {
//            let encoder = JSONEncoder()
//            encoder.keyEncodingStrategy = .convertToSnakeCase
//            let data = try encoder.encode(product)
//            data.append
//            if let jsonString = String(data: data, encoding: .utf8) {
//                print(jsonString)
//            }
//        } catch {
//            completion(.failure(.invalidData))
//        }

    }
}
