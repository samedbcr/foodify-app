//
//  ProductDetailViewController.swift
//  Foodify
//
//  Created by Samed Biçer on 14.08.2021.
//

import UIKit

class ProductDetailViewController: UIViewController {
    private let imageViewContainer = UIView()
    private let imageWithShadowView = ImageWithShadowView()
    private let bottomContainerView = UIView()
    private let titleStackView = UIStackView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()

    var viewModel: ProductDetailViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        viewModel.load()
    }

    private func configure() {
        configureImageViewContainer()
        configureBottomContainerView()
        configureTitleStackView()
        configureTitleLabel()
        configurePriceLabel()
    }

    private func configureImageViewContainer() {
        view.addSubview(imageViewContainer)
        imageViewContainer.translatesAutoresizingMaskIntoConstraints = false
        imageViewContainer.backgroundColor = .appMediumGray

        NSLayoutConstraint.activate([
            imageViewContainer.topAnchor.constraint(equalTo: view.topAnchor),
            imageViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageViewContainer.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageViewContainer.heightAnchor.constraint(equalTo: view.widthAnchor, constant: 40)
        ])

        configureImageView()
    }

    private func configureImageView() {
        imageViewContainer.addSubview(imageWithShadowView)
        imageWithShadowView.setup(with: ImageWithShadowViewUIModel(url: "chicken_plate"))
        imageWithShadowView.backgroundColor = .clear

        NSLayoutConstraint.activate([
            imageWithShadowView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            imageWithShadowView.leadingAnchor.constraint(equalTo: imageViewContainer.leadingAnchor, constant: 32),
            imageWithShadowView.trailingAnchor.constraint(equalTo: imageViewContainer.trailingAnchor, constant: -32),
            imageWithShadowView.bottomAnchor.constraint(equalTo: imageViewContainer.bottomAnchor, constant: -32),
        ])
    }

    private func configureBottomContainerView() {
        view.addSubview(bottomContainerView)
        bottomContainerView.translatesAutoresizingMaskIntoConstraints = false
        bottomContainerView.backgroundColor = .white
        bottomContainerView.layer.cornerRadius = 30
        // Shadow
        bottomContainerView.layer.shadowColor = UIColor.appDarkGray.cgColor
        bottomContainerView.layer.shadowOffset = CGSize(width: 0, height: -2)
        bottomContainerView.layer.shadowOpacity = 0.4
        bottomContainerView.layer.shadowRadius = 8
        bottomContainerView.layer.masksToBounds = false

        NSLayoutConstraint.activate([
            bottomContainerView.topAnchor.constraint(equalTo: imageViewContainer.bottomAnchor, constant: -30),
            bottomContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func configureTitleStackView() {
        bottomContainerView.addSubview(titleStackView)
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.axis = .horizontal
        titleStackView.distribution = .fillProportionally
        titleStackView.alignment = .center
        titleStackView.spacing = 10

        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: 20),
            titleStackView.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 24),
            titleStackView.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor, constant: -24),
        ])
    }

    private func configureTitleLabel() {
        titleLabel.text = "Chicken Meal"
        titleLabel.font = UIFont(name: Fonts.poppinsSemiBold, size: 22)
        titleLabel.textColor = .appDark
        titleLabel.numberOfLines = 0
        titleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        titleStackView.addArrangedSubview(titleLabel)
    }

    private func configurePriceLabel() {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.text = "$24"
        priceLabel.font = UIFont(name: Fonts.poppinsMedium, size: 24)
        priceLabel.textColor = .primary
        priceLabel.textAlignment = .right
        priceLabel.numberOfLines = 1
        priceLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        titleStackView.addArrangedSubview(priceLabel)
    }

}

extension ProductDetailViewController: ProductDetailViewModelDelegate {
    func handleViewOutput(_ output: ProductDetailViewModelOutput) {
        switch output {
        case .reload:
            break
//            print(viewModel.product ?? "empty data")
        case .setLoading(let isLoading):
            print(isLoading)
        }
    }
}
