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

    public init() { }

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
