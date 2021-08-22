//
//  MockFavoriteService.swift
//  FoodifyTests
//
//  Created by Samed Biçer on 22.08.2021.
//

import Foundation
@testable import FoodifyAPI

final class MockFavoriteService: FavoriteServiceProtocol {
    var favorites = [Product]()

    func fetchFavorites(completion: @escaping (Result<[Product], ErrorMessage>) -> Void) {
        completion(.success(favorites))
    }

    func changeFavoriteStatus(_ id: Int, completion: @escaping (Result<SuccessResponse, ErrorMessage>) -> Void) {
        //
    }
}
