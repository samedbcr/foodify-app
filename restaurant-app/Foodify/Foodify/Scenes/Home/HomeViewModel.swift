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
    var categories = [FoodifyAPI.Category]()
    var products = [Product]()
    var selectedCaregoryIds = [Int]()

    private let categoryService: CategoryServiceProtocol
    private let productService: ProductServiceProtocol

    init(categoryService: CategoryServiceProtocol, productService: ProductServiceProtocol) {
        self.categoryService = categoryService
        self.productService = productService
    }

    private func notify(_ output: HomeViewModelOutput) {
        delegate?.handleViewOutput(output)
    }
}

extension HomeViewModel: HomeViewModelProtocol {


    var categoriesCount: Int {
        categories.count
    }

    var productsCount: Int {
        products.count
    }

    func loadCategories() {
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

    func loadProducts() {
        productService.fetchProducts(with: selectedCaregoryIds) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let products):
                self.products = products
                self.notify(.reloadProductList)
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }

    func selectCategory(at index: Int) {
        let categoryId = categories[index].id
        if let firstIndex = selectedCaregoryIds.firstIndex(of: categoryId) {
            selectedCaregoryIds.remove(at: firstIndex)
        } else {
            selectedCaregoryIds.append(categoryId)
        }
        loadProducts()
    }

    func selectProduct(at index: Int) {
        let viewController = ProductDetailViewController()
        let viewModel = ProductDetailViewModel(productService: productService, favoriteService: FavoriteService())
        viewController.viewModel = viewModel
        viewController.productId = products[index].id
        delegate?.navigate(to: viewController)
    }
}
