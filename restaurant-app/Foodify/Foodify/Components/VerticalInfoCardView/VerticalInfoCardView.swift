//
//  VerticalInfoCardView.swift
//  Foodify
//
//  Created by Samed Biçer on 10.08.2021.
//

import UIKit

final class VerticalInfoCardView: UIView {
    private let stackView = UIStackView()
    private let imageWithShadowView = ImageWithShadowView()
    private let titleLabel = UILabel()
    private let ratingStarsView = RatingStarsView()
    private let extraText = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        backgroundColor = .systemGray4
        configureStackView()
        configureImageWithShadowView()
        configureTitleLabel()
        configureRatingStarsView()
    }

    private func configureStackView() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .leading

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        ])
    }

    private func configureImageWithShadowView() {
        stackView.addArrangedSubview(imageWithShadowView)
        
        //TODO
        NSLayoutConstraint.activate([
            imageWithShadowView.topAnchor.constraint(equalTo: topAnchor, constant: -imageWithShadowView.frame.size.height)
        ])
    }

    private func configureTitleLabel() {
        titleLabel.font = UIFont(name: Fonts.poppinsSemiBold, size: 13)
        titleLabel.textColor = .primary
        stackView.addArrangedSubview(titleLabel)
    }

    private func configureRatingStarsView() {
        stackView.addArrangedSubview(ratingStarsView)
    }

    func setup(with model: VerticalInfoCardViewUIModel) {
        imageWithShadowView.setup(with: model.imageWithShadowViewModel)
        ratingStarsView.setup(with: model.ratingStarsViewModel)
        titleLabel.text = model.title
        extraText.text = model.extraText
    }
}
