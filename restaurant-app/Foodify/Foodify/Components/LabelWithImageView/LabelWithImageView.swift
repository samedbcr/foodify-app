//
//  LabelWithImageView.swift
//  Foodify
//
//  Created by Samed Biçer on 9.08.2021.
//

import UIKit
import Kingfisher

final class LabelWithImageView: UIView {
    private let stackView = UIStackView()
    private let imageViewContainer = UIView()
    private let imageView = UIImageView()
    private let label = UILabel()
    private let placeholderImage = UIImage(named: "strawberry")
    private var isDarkText = true

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        configureStackView()
        configureImageViewContainer()
        configureImageView()
        configureLabel()
    }

    private func configureStackView() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    private func configureImageViewContainer() {
        imageViewContainer.layer.cornerRadius = 16
        imageViewContainer.backgroundColor = .clear
        stackView.addArrangedSubview(imageViewContainer)
    }

    private func configureImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = placeholderImage
        imageViewContainer.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.topAnchor.constraint(equalTo: imageViewContainer.topAnchor, constant: 4),
            imageView.leadingAnchor.constraint(equalTo: imageViewContainer.leadingAnchor, constant: 4),
            imageView.trailingAnchor.constraint(equalTo: imageViewContainer.trailingAnchor, constant: -4),
            imageView.bottomAnchor.constraint(equalTo: imageViewContainer.bottomAnchor, constant: -4),
        ])
    }

    private func configureLabel() {
        label.font = UIFont(name: Fonts.poppinsSemiBold, size: 13)
        label.textColor = .appDark
        stackView.addArrangedSubview(label)
    }

    func setup(with model: LabelWithImageUIModel) {
        if model.isBoldText == false {
            label.font = UIFont(name: Fonts.poppinsMedium, size: 13)
        }

        if model.isDarkText == false {
            label.textColor = .appMediumGray
            imageViewContainer.backgroundColor = .appLightGray
        }
        label.text = model.labelText

        imageView.kf.indicatorType = .activity
        imageView.loadImage(from: model.imageURL, nil)
    }

    func toggleIsDarkTextStatus() {
        isDarkText.toggle()
        if isDarkText {
            label.textColor = .appDark
            imageViewContainer.backgroundColor = .clear
        } else {
            label.textColor = .appMediumGray
            imageViewContainer.backgroundColor = .appLightGray
        }
    }
}
