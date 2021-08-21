//
//  FavoriteService.swift
//
//
//  Created by Samed Biçer on 18.08.2021.
//

import Foundation
import Alamofire

public protocol FavoriteServiceProtocol {
    func fetchFavorites(completion: @escaping (Result<[Product], ErrorMessage>) -> Void)
    func changeFavoriteStatus(_ id: Int, completion: @escaping (Result<SuccessResponse, ErrorMessage>) -> Void)
}

public class FavoriteService: FavoriteServiceProtocol {
    let baseURL = "https://app-foodify.herokuapp.com/favorites/"

    public init() { }

    public func fetchFavorites(completion: @escaping (Result<[Product], ErrorMessage>) -> Void) {
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
                    let favorites = try decoder.decode([Product].self, from: data)
                    completion(.success(favorites))
                } catch {
                    completion(.failure(.invalidData))
                }
            }
        }
    }

    public func changeFavoriteStatus(_ id: Int, completion: @escaping (Result<SuccessResponse, ErrorMessage>) -> Void) {
        let endPoint = "\(baseURL)\(id)"

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
                    let successResponse = try decoder.decode(SuccessResponse.self, from: data)
                    completion(.success(successResponse))
                } catch {
                    completion(.failure(.invalidData))
                }
            }
        }
    }
}
