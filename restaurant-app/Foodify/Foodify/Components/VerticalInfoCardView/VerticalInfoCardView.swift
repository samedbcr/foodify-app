//
//  VerticalInfoCardView.swift
//  Foodify
//
//  Created by Samed Biçer on 10.08.2021.
//

import UIKit

final class VerticalInfoCardView: UIView {
    private let imageWithShadowView = ImageWithShadowView()
    private let titleLabel = UILabel()
    private let ratingStarsView = RatingStarsView()
    private let extraText = UILabel()
    private var imageViewTopConstraint: NSLayoutConstraint!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .appMediumGray
        layer.cornerRadius = 42
        configureImageWithShadowView()
        configureTitleLabel()
        configureRatingStarsView()
        configureExtraTextLabel()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageViewTopConstraint.constant = -imageWithShadowView.frame.height / 2
    }

    private func configureImageWithShadowView() {
        addSubview(imageWithShadowView)

        imageViewTopConstraint = imageWithShadowView.topAnchor.constraint(equalTo: topAnchor, constant: -(imageWithShadowView.frame.height / 2))
        NSLayoutConstraint.activate([
            imageViewTopConstraint,
            imageWithShadowView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            imageWithShadowView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            imageWithShadowView.heightAnchor.constraint(equalTo: widthAnchor, constant: -40)
        ])
    }

    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name: Fonts.poppinsSemiBold, size: 14)
        titleLabel.textColor = .primary

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageWithShadowView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }

    private func configureRatingStarsView() {
        addSubview(ratingStarsView)

        NSLayoutConstraint.activate([
            ratingStarsView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            ratingStarsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            ratingStarsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }

    private func configureExtraTextLabel() {
        addSubview(extraText)
        extraText.translatesAutoresizingMaskIntoConstraints = false
        extraText.font = UIFont(name: Fonts.poppinsBold, size: 15)
        extraText.textColor = .primary
        extraText.textAlignment = .right

        NSLayoutConstraint.activate([
            extraText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            extraText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            extraText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }

    func setup(with model: VerticalInfoCardViewUIModel) {
        imageWithShadowView.setup(with: model.imageWithShadowViewModel)
        ratingStarsView.setup(with: model.ratingStarsViewModel)
        titleLabel.text = model.title
        extraText.text = model.extraText
    }
}
