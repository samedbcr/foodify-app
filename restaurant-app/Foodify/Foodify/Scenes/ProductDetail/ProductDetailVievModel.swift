//
//  ProductDetailVievModel.swift
//  Foodify
//
//  Created by Samed Biçer on 14.08.2021.
//

import Foundation
import FoodifyAPI

final class ProductDetailViewModel {
    weak var delegate: ProductDetailViewModelDelegate?
    var product: Product?

    private let service: ProductServiceProtocol

    init(service: ProductServiceProtocol) {
        self.service = service
    }

    private func notify(_ output: ProductDetailViewModelOutput) {
        delegate?.handleViewOutput(output)
    }

}

extension ProductDetailViewModel: ProductDetailViewModelProtocol {

    func load() {
        service.fetchProduct(with: 5) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let product):
                self.product = product
                self.notify(.reload)
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
}
