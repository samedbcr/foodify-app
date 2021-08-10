//
//  PropertyView.swift
//  Foodify
//
//  Created by Samed Biçer on 10.08.2021.
//

import UIKit

final class PropertyView: UIView {
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let labelWithImageView = LabelWithImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        configureStackView()
        configureTitleLabel()
        configureLabelWithImageView()
    }
    
    private func configureStackView() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.spacing = 10
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func configureTitleLabel() {
        titleLabel.font = UIFont(name: Fonts.poppinsSemiBold, size: 14)
        titleLabel.textColor = .appDark
        stackView.addArrangedSubview(titleLabel)
    }
    
    private func configureLabelWithImageView() {
        stackView.addArrangedSubview(labelWithImageView)
    }

    func setup(with model: PropertyViewUIModel) {
        titleLabel.text = model.title
        labelWithImageView.setup(with: model.labelWithImageViewModel)
    }
}
