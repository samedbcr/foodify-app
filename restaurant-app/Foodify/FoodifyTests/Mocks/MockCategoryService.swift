//
//  MockCategoryService.swift
//  FoodifyTests
//
//  Created by Samed Biçer on 22.08.2021.
//

import Foundation
@testable import FoodifyAPI

final class MockCategoryService: CategoryServiceProtocol {
    var categories = [FoodifyAPI.Category]()

    func fetchCategories(completion: @escaping (Result<[FoodifyAPI.Category], ErrorMessage>) -> Void) {
        completion(.success(categories))
    }
}
