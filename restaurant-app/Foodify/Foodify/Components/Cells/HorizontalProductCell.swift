//
//  HorizontalProductCell.swift
//  Foodify
//
//  Created by Samed Biçer on 17.08.2021.
//

import UIKit

class HorizontalProductCell: UICollectionViewCell {
    static let reuseId = "HorizontalProductCell"
    private let horizontalInfoCardView = HorizontalInfoCardView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        configureHorizontalInfoCardView()
    }

    private func configureHorizontalInfoCardView() {
        contentView.addSubview(horizontalInfoCardView)

        NSLayoutConstraint.activate([
            horizontalInfoCardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            horizontalInfoCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            horizontalInfoCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            horizontalInfoCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    func setup(with model: HorizontalInfoCardViewUIModel) {
        horizontalInfoCardView.setup(with: model)
    }


}
