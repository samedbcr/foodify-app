//
//  FavoritesViewModel.swift
//  Foodify
//
//  Created by Samed Biçer on 18.08.2021.
//

import Foundation
import FoodifyAPI

final class FavoritesViewModel {
    weak var delegate: FavoritesViewModelDelegate?
    var products = [Product]()

    private let service: FavoriteServiceProtocol

    init(service: FavoriteServiceProtocol) {
        self.service = service
    }

    private func notify(_ output: FavoritesViewModelOutput) {
        delegate?.handleOutput(output)
    }
}

extension FavoritesViewModel: FavoritesViewModelProtocol {
    var productsCount: Int {
        products.count
    }

    func load() {
        notify(.setLoading(true))
        service.fetchFavorites { [weak self] result in
            guard let self = self else { return }
            self.notify(.setLoading(false))

            switch result {
            case .success(let products):
                self.products = products
                self.notify(.reload)
            case.failure(let error):
                print("error: \(error)")
            }
        }
    }

    func selectProduct(at index: Int) {
        let viewController = ProductDetailViewController()
        let viewModel = ProductDetailViewModel(productService: ProductService(), favoriteService: FavoriteService(), cartService: CartService())
        viewController.viewModel = viewModel
        viewController.productId = products[index].id
        delegate?.navigate(to: viewController)
    }
}
