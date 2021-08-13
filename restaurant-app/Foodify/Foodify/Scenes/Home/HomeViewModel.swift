//
//  HomeViewModel.swift
//  Foodify
//
//  Created by Samed Biçer on 12.08.2021.
//

import Foundation
import FoodifyAPI

final class HomeViewModel {
    weak var delegate: HomeViewModelDelegate?
    private let categoryService: CategoryServiceProtocol
    var categories = [FoodifyAPI.Category]()

    init(categoryService: CategoryServiceProtocol) {
        self.categoryService = categoryService
    }

    private func notify(_ output: HomeViewModelOutput) {
        delegate?.handleViewOutput(output)
    }
}

extension HomeViewModel: HomeViewModelProtocol {

    var categoriesCount: Int {
        categories.count
    }

    func load() {
        categoryService.fetchCategories { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let categories):
                self.categories = categories
                self.notify(.reloadCategoryList)
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }

    func selectCategory(at index: Int) {
        // TODO
    }
}
