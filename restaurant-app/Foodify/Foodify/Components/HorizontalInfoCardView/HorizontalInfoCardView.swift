//
//  HorizontalInfoCardView.swift
//  Foodify
//
//  Created by Samed Biçer on 11.08.2021.
//

import UIKit

final class HorizontalInfoCardView: UIView {
    private let imageWithShadowView = ImageWithShadowView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let increaseDecreaseView = IncreaseDecreaseView()
    private let extraText = UILabel()
    private let hStackView = UIStackView()
    private let vStackView = UIStackView()

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
        layer.cornerRadius = 14
        configureHStackView()
        configureImageWithShadowView()
        configureVStackView()
        configureTitleLabel()
        configureDescriptionLabel()
        configureIncreaseDecreaseView()
        configureExtraTextLabel()
    }

    private func configureHStackView() {
        addSubview(hStackView)
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.axis = .horizontal
        hStackView.distribution = .fill
        hStackView.alignment = .top
        hStackView.spacing = 8
        NSLayoutConstraint.activate([
            hStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            hStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            hStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            hStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18),
        ])
    }

    private func configureImageWithShadowView() {
        hStackView.addArrangedSubview(imageWithShadowView)

        NSLayoutConstraint.activate([
            imageWithShadowView.widthAnchor.constraint(equalTo: hStackView.heightAnchor)
        ])
    }

    private func configureVStackView() {
        vStackView.axis = .vertical
        vStackView.distribution = .fill
        vStackView.alignment = .leading
        vStackView.spacing = 6
        hStackView.addArrangedSubview(vStackView)

        NSLayoutConstraint.activate([
            hStackView.bottomAnchor.constraint(equalTo: vStackView.bottomAnchor)
        ])
    }

    private func configureTitleLabel() {
        titleLabel.font = UIFont(name: Fonts.poppinsSemiBold, size: 15)
        titleLabel.textColor = .appDark

        vStackView.addArrangedSubview(titleLabel)
    }

    private func configureDescriptionLabel() {
        descriptionLabel.font = UIFont(name: Fonts.poppinsSemiBold, size: 12)
        descriptionLabel.textColor = .appDarkGray

        vStackView.addArrangedSubview(descriptionLabel)
    }

    private func configureIncreaseDecreaseView() {
        vStackView.addArrangedSubview(increaseDecreaseView)
    }

    private func configureExtraTextLabel() {
        extraText.font = UIFont(name: Fonts.poppinsSemiBold, size: 17)
        extraText.textColor = .primary

        hStackView.addArrangedSubview(extraText)
    }

    func setup(with model: HorizontalInfoCardViewUIModel) {
        imageWithShadowView.setup(with: model.imageWithShadowViewModel)
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        extraText.text = model.extraText
        
        if let increaseDecreaseViewModel = model.increaseDecreaseViewModel {
            increaseDecreaseView.setup(with: increaseDecreaseViewModel)
        }
    }
}
