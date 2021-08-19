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

    private let productService: ProductServiceProtocol
    private let favoriteService: FavoriteServiceProtocol

    init(productService: ProductServiceProtocol, favoriteService: FavoriteServiceProtocol) {
        self.productService = productService
        self.favoriteService = favoriteService
    }

    private func notify(_ output: ProductDetailViewModelOutput) {
        delegate?.handleViewOutput(output)
    }

}

extension ProductDetailViewModel: ProductDetailViewModelProtocol {
    func load(id: Int?) {
        guard let id = id else { return }
        productService.fetchProduct(with: id) { [weak self] result in
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

    func generatePropertiesUIModel() -> PropertiesStackViewUIModel? {
        var models = [PropertyViewUIModel]()

        if let ingredients = product?.ingredients {
            ingredients.forEach {
                let propertyViewUIModel = PropertyViewUIModel(title: $0.name, labelWithImageViewModel: LabelWithImageUIModel(imageURL: $0.imagePath, labelText: "\($0.value)g", isBoldText: true, isDarkText: true))
                models.append(propertyViewUIModel)
            }
        }

        return PropertiesStackViewUIModel(properties: models)
    }

    func changeFavoriteStatus(id: Int?) {
        guard let id = id else { return }
        favoriteService.changeFavoriteStatus(id) { result in
//            guard let self = self else { return }
            switch result {
            case .success(let successResponse):
                print(successResponse.message)
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }

}
