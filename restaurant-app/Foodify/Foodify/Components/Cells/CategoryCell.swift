//
//  CategoryCell.swift
//  Foodify
//
//  Created by Samed Biçer on 13.08.2021.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    static let reuseId = "CategoryCell"
    private let categoryCardView = CategoryCardView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        configureCategoryCardView()
    }

    private func configureCategoryCardView() {
        contentView.addSubview(categoryCardView)
        NSLayoutConstraint.activate([
            categoryCardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            categoryCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    func setup(with model: CategoryCardViewUIModel) {
        categoryCardView.setup(with: model)
    }

    func changeCategorySelectedStatus() {
        categoryCardView.toggleSelectedStatus()
    }
}
