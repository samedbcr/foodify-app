//
//  ReceiptCell.swift
//  Foodify
//
//  Created by Samed Biçer on 17.08.2021.
//

import UIKit

class ReceiptCell: UICollectionViewCell {
    static let reuseId = "ReceiptCell"
    private let basicTableRowView = BasicTableRowView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        configureBasicTableRowView()
    }

    private func configureBasicTableRowView() {
        contentView.addSubview(basicTableRowView)

        NSLayoutConstraint.activate([
            basicTableRowView.topAnchor.constraint(equalTo: contentView.topAnchor),
            basicTableRowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            basicTableRowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            basicTableRowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    func setup(with model: BasicTableRowViewUIModel) {
        basicTableRowView.setup(with: model)
    }

}
