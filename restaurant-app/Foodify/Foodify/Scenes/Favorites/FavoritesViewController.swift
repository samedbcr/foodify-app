//
//  FavoritesViewController.swift
//  Foodify
//
//  Created by Samed Biçer on 18.08.2021.
//

import UIKit

final class FavoritesViewController: UIViewController {
    private var collectionView: UICollectionView!

    var viewModel: FavoritesViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.load()
    }

    private func configure() {
        view.backgroundColor = .white
        title = "Favorites"
        tabBarItem.title = ""
        configureCollectionView()
    }

    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createSingleColumnsFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.register(HorizontalProductCell.self, forCellWithReuseIdentifier: HorizontalProductCell.reuseId)
        collectionView.delegate = self
        collectionView.dataSource = self

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension FavoritesViewController: FavoritesViewModelDelegate {
    func handleOutput(_ output: FavoritesViewModelOutput) {
        switch output {
        case.reload:
            collectionView.reloadData()
        case.setLoading(let isLoading):
            setLoading(status: isLoading)
        }
    }
}

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.productsCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalProductCell.reuseId, for: indexPath) as! HorizontalProductCell

        let product = viewModel.products[indexPath.row]

        let model = HorizontalInfoCardViewUIModel(
            imageWithShadowViewModel: ImageWithShadowViewUIModel(url: product.imagePath),
            title: product.name,
            description: product.description,
            increaseDecreaseViewModel: nil,
            extraText: "$\(Int(product.price))")
        cell.setup(with: model)

        return cell

    }


}
