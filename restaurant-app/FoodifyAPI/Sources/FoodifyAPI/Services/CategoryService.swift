//
//  CategoryService.swift
//
//
//  Created by Samed Biçer on 12.08.2021.
//

import Foundation
import Alamofire

public protocol CategoryServiceProtocol {
    func fetchCategories(completion: @escaping (Result<[Category], ErrorMessage>) -> Void)
}

public class CategoryService: CategoryServiceProtocol {
    let baseURL = "https://app-foodify.herokuapp.com/categories/"

//    let mockCategories: [Category] = [
//        Category(imagePath: "strawberry", name: "Dessert"),
//        Category(imagePath: "pizza", name: "Pizza"),
//        Category(imagePath: "hamburger", name: "Hamburger"),
//        Category(imagePath: "strawberry", name: "Fruit")
//    ]

    public init() { }

    public func fetchCategories(completion: @escaping (Result<[Category], ErrorMessage>) -> Void) {
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
                    let categories = try decoder.decode([Category].self, from: data)
                    completion(.success(categories))
                } catch {
                    completion(.failure(.invalidData))
                }
            }
        }

        //        completion(.success(mockCategories))
    }
}
