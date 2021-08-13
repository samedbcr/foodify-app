//
//  CategoryCardView.swift
//  Foodify
//
//  Created by Samed Biçer on 9.08.2021.
//

import UIKit

class CategoryCardView: UIView {
    let labelWithImageView = LabelWithImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .appLightGray
        layer.cornerRadius = 24
        configureLabelWithImageView()
    }

    private func configureLabelWithImageView() {
        addSubview(labelWithImageView)
        labelWithImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            labelWithImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            labelWithImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            labelWithImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            labelWithImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }

    func setup(with model: CategoryCardViewUIModel) {
        if model.isSelected {
            backgroundColor = .primary
        }
        labelWithImageView.setup(with: model.labelWithImageViewModel)
    }
}
