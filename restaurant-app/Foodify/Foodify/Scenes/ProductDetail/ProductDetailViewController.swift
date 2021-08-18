//
//  ProductDetailViewController.swift
//  Foodify
//
//  Created by Samed Biçer on 14.08.2021.
//

import UIKit

final class ProductDetailViewController: UIViewController {
    var productId: Int?
    private let favoriteBarButton = UIBarButtonItem()
    private let imageViewContainer = UIView()
    private let imageWithShadowView = ImageWithShadowView()
    private let bottomContainerView = UIView()
    private let titleStackView = UIStackView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let propertiesStackView = PropertiesStackView()
    private let descriptionsTitleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let footerStackView = UIStackView()
    private let increaseDecreaseView = IncreaseDecreaseView()
    private let addButton = CustomButton()

    var viewModel: ProductDetailViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        viewModel.load(id: productId)
    }

    private func configure() {
        configureFavoriteBarButton()
        configureImageViewContainer()
        configureBottomContainerView()
        configureTitleStackView()
        configureTitleLabel()
        configurePriceLabel()
        configurePropertiesStackView()
        configureDescriptionsTitleLabel()
        configureDescriptionLabel()
        configureFooterStackView()
    }

    private func configureFavoriteBarButton() {
        let imageName = "heart.circle.fill"
        favoriteBarButton.image = UIImage(systemName: imageName)
        favoriteBarButton.tintColor = .systemRed
        favoriteBarButton.style = .plain
        favoriteBarButton.target = self
//        favoriteBarButton.action = #selector(favoriteButtonClicked)
        navigationItem.setRightBarButton(favoriteBarButton, animated: true)
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
            bottomContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 30)
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

    private func configurePropertiesStackView() {
        bottomContainerView.addSubview(propertiesStackView)
//        let firstProperty = PropertyViewUIModel(title: "Carb", labelWithImageViewModel: LabelWithImageUIModel(imageURL: "strawberry", labelText: "180g", isBoldText: false, isDarkText: true))
//        let secondProperty = PropertyViewUIModel(title: "Protein", labelWithImageViewModel: LabelWithImageUIModel(imageURL: "strawberry", labelText: "20g", isBoldText: false, isDarkText: true))
//        let thirdProperty = PropertyViewUIModel(title: "Fat", labelWithImageViewModel: LabelWithImageUIModel(imageURL: "strawberry", labelText: "30g", isBoldText: false, isDarkText: true))
//        propertiesStackView.setup(with: PropertiesStackViewUIModel(properties: [firstProperty, secondProperty, thirdProperty]))

        NSLayoutConstraint.activate([
            propertiesStackView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 20),
            propertiesStackView.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 24),
            propertiesStackView.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor, constant: -24),
        ])
    }

    private func configureDescriptionsTitleLabel() {
        bottomContainerView.addSubview(descriptionsTitleLabel)
        descriptionsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionsTitleLabel.text = "Description".uppercased()
        descriptionsTitleLabel.font = UIFont(name: Fonts.poppinsMedium, size: 16)
        descriptionsTitleLabel.textColor = .appDarkGray

        NSLayoutConstraint.activate([
            descriptionsTitleLabel.topAnchor.constraint(equalTo: propertiesStackView.bottomAnchor, constant: 20),
            descriptionsTitleLabel.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 24),
            descriptionsTitleLabel.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor, constant: -24),

        ])
    }

    private func configureDescriptionLabel() {
        bottomContainerView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "Hello world this is an amazin meat that made in Turkey. Please try it and don't forget to give a feedback about its taste and delivery quality!"
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont(name: Fonts.poppinsMedium, size: 15)
        descriptionLabel.textColor = .systemGray

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: descriptionsTitleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor, constant: -24),

        ])
    }

    private func configureFooterStackView() {
        view.addSubview(footerStackView)
        footerStackView.translatesAutoresizingMaskIntoConstraints = false
        footerStackView.axis = .horizontal
        footerStackView.distribution = .fillEqually
        footerStackView.alignment = .center
        footerStackView.spacing = 32

        increaseDecreaseView.setup(with: IncreaseDecreaseViewUIModel(
            decreaseButton: SmallIconButtonUIModel(
                icon: "minus",
                backgroundColor: "appDarkGray",
                iconColor: "appLightGray",
                radius: 6),
            text: "1",
            increaseButton: SmallIconButtonUIModel(
                icon: "plus",
                backgroundColor: "primary",
                iconColor: "appLightGray",
                radius: 6)))

        addButton.setTitle("Add to cart", for: .normal)
        footerStackView.addArrangedSubview(increaseDecreaseView)
        footerStackView.addArrangedSubview(addButton)

        NSLayoutConstraint.activate([
            footerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            footerStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.68),
            footerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

}

extension ProductDetailViewController: ProductDetailViewModelDelegate {
    func handleViewOutput(_ output: ProductDetailViewModelOutput) {
        switch output {
        case .reload:
            if let product = viewModel.product {
                imageWithShadowView.setup(with: ImageWithShadowViewUIModel(url: product.imagePath))
                titleLabel.text = product.name
                priceLabel.text = "$\(Int(product.price))"
                descriptionLabel.text = product.description
            }

            if let propertiesModel = viewModel.generatePropertiesUIModel() {
                propertiesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
                propertiesStackView.setup(with: propertiesModel)
            }
        case .setLoading(let isLoading):
            print(isLoading)
        }
    }


}

