//
//  HomeViewModel.swift
//  Foodify
//
//  Created by Samed Biçer on 12.08.2021.
//

import Foundation
import FoodifyAPI

final class HomeViewModel: HomeViewModelProtocol {
    weak var delegate: HomeViewModelDelegate?
    private let categoryService: CategoryServiceProtocol
    private var categories = [FoodifyAPI.Category]()

    init(categoryService: CategoryServiceProtocol) {
        self.categoryService = categoryService
    }

    func load() {
        categoryService.fetchCategories { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let categories):
                print(categories)
                self.notify(.reloadCategoryList)
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }

    func selectCategory(at index: Int) {
        // TODO
    }

    private func notify(_ output: HomeViewModelOutput) {
        delegate?.handleViewOutput(output)
    }
}
