//
//  ProductCell.swift
//  Foodify
//
//  Created by Samed Biçer on 13.08.2021.
//

import UIKit

class ProductCell: UICollectionViewCell {
    static let reuseId = "ProductCell"
    private let verticalInfoCardView = VerticalInfoCardView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        configureVerticalInfoCardView()
    }

    private func configureVerticalInfoCardView() {
        contentView.addSubview(verticalInfoCardView)
        NSLayoutConstraint.activate([
            verticalInfoCardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: (contentView.frame.size.width - 40) / 2),
            verticalInfoCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            verticalInfoCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            verticalInfoCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    func setup(with model: VerticalInfoCardViewUIModel) {
        verticalInfoCardView.setup(with: model)
    }
}
