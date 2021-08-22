//
//  HomeSceneTests.swift
//  FoodifyTests
//
//  Created by Samed Biçer on 22.08.2021.
//

import XCTest
@testable import Foodify

class HomeSceneTests: XCTestCase {

    private var view: MockHomeView!
    private var viewModel: HomeViewModel!
    private var categoryService: MockCategoryService!
    private var productService: MockProductService!


    override func setUp() {
        categoryService = MockCategoryService()
        productService = MockProductService()
        viewModel = HomeViewModel(categoryService: categoryService, productService: productService)
        view = MockHomeView()
        viewModel.delegate = view
    }

    override func tearDown() {
        view = nil
        categoryService = nil
        productService = nil
        viewModel = nil
    }

    func test_loadCategories() throws {
        // Before
        XCTAssertTrue(viewModel.categories.isEmpty)
        XCTAssertEqual(viewModel.categoriesCount, 0)

        // Given
        let categories = try ResourceLoader.loadCategories(resource: .categories)
        categoryService.categories = categories

        // When
        viewModel.loadCategories()

        // Then
        XCTAssertEqual(viewModel.categoriesCount, categories.count)
        XCTAssertEqual(viewModel.categories[0].name, "Meat")
        XCTAssertEqual(viewModel.categories[1].imagePath, "https://foodify-app.s3.eu-west-3.amazonaws.com/salad_icon.png")
        XCTAssertEqual(view.outputs.count, 1)
        XCTAssertEqual(view.outputs[0], .reloadCategoryList)
    }

    func test_loadProducts() throws {
        // Before
        XCTAssertTrue(viewModel.products.isEmpty)
        XCTAssertEqual(viewModel.productsCount, 0)

        // Given
        let product1 = try ResourceLoader.loadProduct(resource: .product_1)
        let product2 = try ResourceLoader.loadProduct(resource: .product_2)
        let product3 = try ResourceLoader.loadProduct(resource: .product_3)
        let products = [product1, product2, product3]
        productService.products = products

        // When
        viewModel.loadProducts()

        // Then
        XCTAssertEqual(viewModel.productsCount, products.count)
        XCTAssertEqual(viewModel.products[0].name, "Burrata Salad")
        XCTAssertEqual(viewModel.products[1].price, 20)
        XCTAssertEqual(view.outputs.count, 3)
        XCTAssertEqual(view.outputs[0], .setLoading(true))
        XCTAssertEqual(view.outputs[1], .setLoading(false))
        XCTAssertEqual(view.outputs[2], .reloadProductList)
    }

    func test_selectCategory_withSelectedCategory() throws {
        // Given
        let selectedCategoryIndex = 1
        let categories = try ResourceLoader.loadCategories(resource: .categories)
        viewModel.categories = categories
        let selectedCategory = categories[selectedCategoryIndex]
        viewModel.selectedCategoryIds = [selectedCategory.id, 8, 12]

        // When
        viewModel.selectCategory(at: selectedCategoryIndex)

        // Then
        XCTAssertFalse(viewModel.selectedCategoryIds.contains(selectedCategory.id))
        XCTAssertEqual(viewModel.selectedCategoryIds.count, 2)
        XCTAssertEqual(view.outputs.count, 3)
        XCTAssertEqual(view.outputs[0], .setLoading(true))
        XCTAssertEqual(view.outputs[1], .setLoading(false))
        XCTAssertEqual(view.outputs[2], .reloadProductList)
    }

    func test_selectCategory_withNonselectedCategory() throws {
        // Given
        let selectedCategoryIndex = 1
        let categories = try ResourceLoader.loadCategories(resource: .categories)
        viewModel.categories = categories
        let selectedCategory = categories[selectedCategoryIndex]
        viewModel.selectedCategoryIds = [8, 12]

        // When
        viewModel.selectCategory(at: selectedCategoryIndex)

        // Then
        XCTAssertTrue(viewModel.selectedCategoryIds.contains(selectedCategory.id))
        XCTAssertEqual(viewModel.selectedCategoryIds.count, 3)
        XCTAssertEqual(view.outputs.count, 3)
        XCTAssertEqual(view.outputs[0], .setLoading(true))
        XCTAssertEqual(view.outputs[1], .setLoading(false))
        XCTAssertEqual(view.outputs[2], .reloadProductList)
    }

    func test_selectProduct() throws {
        // Given
        let product1 = try ResourceLoader.loadProduct(resource: .product_1)
        let product2 = try ResourceLoader.loadProduct(resource: .product_2)
        let product3 = try ResourceLoader.loadProduct(resource: .product_3)
        let products = [product1, product2, product3]
        productService.products = products
        viewModel.loadProducts()

        // When
        viewModel.selectProduct(at: 0)

        // Then
        XCTAssertTrue(view.isNavigatedToDetail)
    }
}

final class MockHomeView: HomeViewModelDelegate {
    var outputs = [HomeViewModelOutput]()
    var isNavigatedToDetail = false

    func handleViewOutput(_ output: HomeViewModelOutput) {
        outputs.append(output)
    }

    func navigate(to route: ProductDetailViewController) {
        isNavigatedToDetail = true
    }
}
