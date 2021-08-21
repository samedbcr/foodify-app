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
    func deleteCart(completion: @escaping (Result<SuccessResponse, ErrorMessage>) -> Void)
}

public class CartService: CartServiceProtocol {
    let baseURL = "https://app-foodify.herokuapp.com/cart/"

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
    }

    public func deleteCart(completion: @escaping (Result<SuccessResponse, ErrorMessage>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(.failure(.invalidURL))
            return
        }

        AF.request(url, method: .delete).responseData { response in
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
    }
}
