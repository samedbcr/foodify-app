//
//  CartViewModel.swift
//  Foodify
//
//  Created by Samed Biçer on 17.08.2021.
//

import Foundation
import FoodifyAPI

final class CartViewModel {
    weak var delegate: CartViewModelDelegate?
    var cart = [Cart]()

    private let service: CartServiceProtocol

    init(service: CartServiceProtocol) {
        self.service = service
    }

    private func notify(_ output: CartViewModelOutput) {
        delegate?.handleViewOutput(output)
    }

}

extension CartViewModel: CartViewModelProtocol {
    var totalPrice: Int {
        var total = 0

        cart.forEach { item in
            total += Int(item.price) * item.count
        }

        return total
    }

    var cartCount: Int {
        cart.count
    }

    func load() {
        notify(.setLoading(true))
        service.fetchCart { [weak self] result in
            guard let self = self else { return }
            self.notify(.setLoading(false))

            switch result {
            case .success(let cart):
                self.cart = cart
                self.notify(.reload)
            case .failure(let error):
                print("error \(error)")
            }
        }
    }

    func deleteAll() {
        notify(.setLoading(true))
        service.deleteCart { [weak self] result in
            guard let self = self else { return }
            self.notify(.setLoading(false))

            switch result {
            case .success:
                self.cart = []
                self.notify(.reload)
            case .failure(let error):
                print("error \(error)")
            }
        }
    }

    func selectProduct(at index: Int) {
        let viewController = ProductDetailViewController()
        let viewModel = ProductDetailViewModel(productService: ProductService(), favoriteService: FavoriteService(), cartService: CartService())
        viewController.viewModel = viewModel
        viewController.productId = cart[index].productId
        delegate?.navigate(to: viewController)
    }
}
