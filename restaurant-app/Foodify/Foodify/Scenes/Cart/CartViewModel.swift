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
            total += Int(item.price)
        }

        return total
    }

    var cartCount: Int {
        cart.count
    }

    func load() {
        service.fetchCart { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let cart):
                self.cart = cart
                self.notify(.reload)
            case .failure(let error):
                print("error \(error)")
            }
        }
    }
}
