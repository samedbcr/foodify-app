//
//  HomeViewController.swift
//  Foodify
//
//  Created by Samed Biçer on 12.08.2021.
//

import UIKit

class HomeViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let entryLabel = UILabel()
    private let categoryLabel = UILabel()
    private var categoriesCollectionView: UICollectionView!
    private var productsCollectionView: UICollectionView!

    var viewModel: HomeViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        viewModel.load()
    }

    private func configure() {
        view.backgroundColor = .white
        configureScrollView()
        configureContentView()
        configureEntryLabel()
        configureCategoryLabel()
        configureCategoriesCollectionView()
        configureProductsCollectionView()
    }

    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func configureContentView() {
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
        ])
    }

    private func configureEntryLabel() {
        contentView.addSubview(entryLabel)
        entryLabel.translatesAutoresizingMaskIntoConstraints = false
        entryLabel.text = "Let's find your favorite food!"
        entryLabel.textColor = .appDark
        entryLabel.font = UIFont(name: Fonts.poppinsSemiBold, size: 26)
        entryLabel.numberOfLines = 0

        NSLayoutConstraint.activate([
            entryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            entryLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            entryLabel.widthAnchor.constraint(equalToConstant: view.frame.width * 0.7)
        ])
    }

    private func configureCategoryLabel() {
        contentView.addSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.text = "Categories"
        categoryLabel.textColor = .appDark
        categoryLabel.font = UIFont(name: Fonts.poppinsSemiBold, size: 18)

        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: entryLabel.bottomAnchor, constant: 16),
            categoryLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            categoryLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
        ])
    }

    private func configureCategoriesCollectionView() {
        categoriesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createCategoriesFlowLayout())
        contentView.addSubview(categoriesCollectionView)
        categoriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoriesCollectionView.showsHorizontalScrollIndicator = false
        categoriesCollectionView.backgroundColor = .white
        categoriesCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseId)
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self

        NSLayoutConstraint.activate([
            categoriesCollectionView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 12),
            categoriesCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            categoriesCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            categoriesCollectionView.heightAnchor.constraint(equalToConstant: 50)

        ])
    }

    private func configureProductsCollectionView() {
        productsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createTwoColumnsFlowLayout(in: view))
        contentView.addSubview(productsCollectionView)
        productsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        productsCollectionView.showsVerticalScrollIndicator = false
        productsCollectionView.backgroundColor = .white
        productsCollectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseId)
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self

        NSLayoutConstraint.activate([
            productsCollectionView.topAnchor.constraint(equalTo: categoriesCollectionView.bottomAnchor, constant: 4),
            productsCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            productsCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            productsCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }

}

extension HomeViewController: HomeViewModelDelegate {
    func handleViewOutput(_ output: HomeViewModelOutput) {
        switch output {
        case .reloadCategoryList:
            categoriesCollectionView.reloadData()
        case .setLoading(let isLoading):
            print(isLoading)
        case .reloadProductList:
            productsCollectionView.reloadData()
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.categoriesCollectionView {
            return viewModel.categoriesCount
        }
        // Product Collection View
        return viewModel.productsCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.categoriesCollectionView {
            let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseId, for: indexPath) as! CategoryCell
            let category = viewModel.categories[indexPath.row]
            let model = CategoryCardViewUIModel(
                labelWithImageViewModel: LabelWithImageUIModel(imageURL: category.imagePath, labelText: category.name, isBoldText: true, isDarkText: true),
                isSelected: false)
            cell.setup(with: model)
            return cell
        }

        // Product Collection View
        let cell = productsCollectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseId, for: indexPath) as! ProductCell
        let product = viewModel.products[indexPath.row]
        let model = VerticalInfoCardViewUIModel(
            imageWithShadowViewModel: ImageWithShadowViewUIModel(url: product.imagePath),
            title: product.name,
            ratingStarsViewModel: RatingStarsViewUIModel(count: product.ratingCount),
            extraText: "$\(Int(product.price))")
        cell.setup(with: model)
        return cell
    }
}
