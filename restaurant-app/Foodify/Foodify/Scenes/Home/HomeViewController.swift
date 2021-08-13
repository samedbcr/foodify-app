//
//  HomeViewController.swift
//  Foodify
//
//  Created by Samed Biçer on 12.08.2021.
//

import UIKit

class HomeViewController: UIViewController {
    private let entryLabel = UILabel()
    private let categoryLabel = UILabel()
    private var categoriesCollectionView: UICollectionView!

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
        configureEntryLabel()
        configureCategoryLabel()
        configureCategoriesCollectionView()
    }

    private func configureEntryLabel() {
        view.addSubview(entryLabel)
        entryLabel.translatesAutoresizingMaskIntoConstraints = false
        entryLabel.text = "Let's find your favorite food!"
        entryLabel.textColor = .appDark
        entryLabel.font = UIFont(name: Fonts.poppinsSemiBold, size: 26)
        entryLabel.numberOfLines = 0

        NSLayoutConstraint.activate([
            entryLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            entryLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            entryLabel.widthAnchor.constraint(equalToConstant: view.frame.width * 0.7)
        ])
    }

    private func configureCategoryLabel() {
        view.addSubview(categoryLabel)
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
        view.addSubview(categoriesCollectionView)
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

}

extension HomeViewController: HomeViewModelDelegate {
    func handleViewOutput(_ output: HomeViewModelOutput) {
        switch output {
        case .reloadCategoryList:
            categoriesCollectionView.reloadData()
        case .setLoading(let isLoading):
            print(isLoading)
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.categoriesCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseId, for: indexPath) as! CategoryCell
        let category = viewModel.categories[indexPath.row]
        let model = CategoryCardViewUIModel(
            labelWithImageViewModel: LabelWithImageUIModel(imageURL: category.imagePath, labelText: category.name, isBoldText: true, isDarkText: true),
            isSelected: false)
        cell.setup(with: model)
        return cell
    }


}
