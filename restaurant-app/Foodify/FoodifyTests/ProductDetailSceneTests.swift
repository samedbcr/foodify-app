//
//  ProductDetailSceneTests.swift
//  FoodifyTests
//
//  Created by Samed Biçer on 22.08.2021.
//

import XCTest
@testable import Foodify

class ProductDetailSceneTests: XCTestCase {
    private var view: MockDetailView!
    private var viewModel: ProductDetailViewModel!
    private var productService: MockProductService!
    private var favoriteService: MockFavoriteService!
    private var cartService: MockCartService!

    override func setUp() {
        productService = MockProductService()
        favoriteService = MockFavoriteService()
        cartService = MockCartService()
        viewModel = ProductDetailViewModel(productService: productService, favoriteService: favoriteService, cartService: cartService)
        view = MockDetailView()
        viewModel.delegate = view
    }

    override func tearDown() {
        view = nil
        productService = nil
        cartService = nil
        favoriteService = nil
        viewModel = nil
    }

    func test_loadProduct() throws {
        // Before
        XCTAssertNil(viewModel.product)

        // Given
        let product = try ResourceLoader.loadProduct(resource: .product_1)
        productService.product = product

        // When
        viewModel.load(id: product.id)

        // Then
        XCTAssertNotNil(viewModel.product)
        XCTAssertEqual(viewModel.product?.name, "Burrata Salad")
        XCTAssertEqual(viewModel.product?.price, 24)
        XCTAssertEqual(view.outputs.count, 3)
        XCTAssertEqual(view.outputs[0], .setLoading(true))
        XCTAssertEqual(view.outputs[1], .setLoading(false))
        XCTAssertEqual(view.outputs[2], .reload)
    }

    func test_addToCart() throws {
        // Given
        let product = try ResourceLoader.loadProduct(resource: .product_1)
        viewModel.product = product

        // When
        viewModel.addToCart(productCount: 2)

        // Then
        XCTAssertEqual(view.outputs.count, 3)
        XCTAssertEqual(view.outputs[0], .setLoading(true))
        XCTAssertEqual(view.outputs[1], .setLoading(false))
        XCTAssertEqual(view.outputs[2], .showAlert)
    }

}

final class MockDetailView: ProductDetailViewModelDelegate {
    var outputs = [ProductDetailViewModelOutput]()

    func handleViewOutput(_ output: ProductDetailViewModelOutput) {
        outputs.append(output)
    }

}
