//
//  ProductDetailViewController.swift
//  Foodify
//
//  Created by Samed Biçer on 14.08.2021.
//

import UIKit

final class ProductDetailViewController: UIViewController {
    var productId: Int?
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let favoriteBarButton = UIBarButtonItem()
    private let imageViewContainer = UIView()
    private let imageWithShadowView = ImageWithShadowView()
    private let bottomContainerView = UIView()
    private let titleStackView = UIStackView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let propertiesStackView = PropertiesStackView()
    private let descriptionLabel = UILabel()
    private let increaseDecreaseView = IncreaseDecreaseView()
    private let addButton = CustomButton()
    private let footerView = UIView()
    private var isFavorited = false

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
        configureScrollVeiw()
        configureContentView()
        configureImageViewContainer()
        configureBottomContainerView()
        configureTitleStackView()
        configureTitleLabel()
        configurePriceLabel()
        configurePropertiesStackView()
        configureDescriptionLabel()
        configureFooterView()
        configureIncreaseDecreaseView()
        configureAddButton()
    }

    private func configureFavoriteBarButton() {
        favoriteBarButton.image = UIImage(systemName: favoriteIcon.notFavorited.rawValue)
        favoriteBarButton.tintColor = .systemRed
        favoriteBarButton.style = .plain
        favoriteBarButton.target = self
        favoriteBarButton.action = #selector(favoriteButtonClicked)
        navigationItem.setRightBarButton(favoriteBarButton, animated: true)
    }

    private func configureScrollVeiw() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsVerticalScrollIndicator = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -56),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func configureContentView() {
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }

    private func configureImageViewContainer() {
        contentView.addSubview(imageViewContainer)
        imageViewContainer.translatesAutoresizingMaskIntoConstraints = false
        imageViewContainer.backgroundColor = .appMediumGray

        NSLayoutConstraint.activate([
            imageViewContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
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
            imageWithShadowView.bottomAnchor.constraint(equalTo: imageViewContainer.bottomAnchor, constant: -36),
        ])
    }

    private func configureBottomContainerView() {
        contentView.addSubview(bottomContainerView)
        bottomContainerView.translatesAutoresizingMaskIntoConstraints = false
        bottomContainerView.backgroundColor = .white
        bottomContainerView.layer.cornerRadius = 30
        // Shadow
        bottomContainerView.layer.shadowColor = UIColor.appDarkGray.cgColor
        bottomContainerView.layer.shadowOffset = CGSize(width: 0, height: -2)
        bottomContainerView.layer.shadowOpacity = 0.3
        bottomContainerView.layer.shadowRadius = 8
        bottomContainerView.layer.masksToBounds = false

        NSLayoutConstraint.activate([
            bottomContainerView.topAnchor.constraint(equalTo: imageViewContainer.bottomAnchor, constant: -30),
            bottomContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
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
        titleLabel.font = UIFont(name: Fonts.poppinsSemiBold, size: 22)
        titleLabel.textColor = .appDark
        titleLabel.numberOfLines = 0
        titleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        titleStackView.addArrangedSubview(titleLabel)
    }

    private func configurePriceLabel() {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.font = UIFont(name: Fonts.poppinsMedium, size: 24)
        priceLabel.textColor = .primary
        priceLabel.textAlignment = .right
        priceLabel.numberOfLines = 1
        priceLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        titleStackView.addArrangedSubview(priceLabel)
    }

    private func configurePropertiesStackView() {
        bottomContainerView.addSubview(propertiesStackView)

        NSLayoutConstraint.activate([
            propertiesStackView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 16),
            propertiesStackView.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 24),
            propertiesStackView.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor, constant: -24),
        ])
    }

    private func configureDescriptionLabel() {
        bottomContainerView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont(name: Fonts.poppinsMedium, size: 15)
        descriptionLabel.textColor = .systemGray

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: propertiesStackView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor, constant: -24),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomContainerView.bottomAnchor, constant: -16)
        ])
    }

    private func configureFooterView() {
        view.addSubview(footerView)
        footerView.translatesAutoresizingMaskIntoConstraints = false
        footerView.backgroundColor = .white
        // Shadow
        footerView.layer.shadowColor = UIColor.appDarkGray.cgColor
        footerView.layer.shadowOffset = CGSize(width: 0, height: -2)
        footerView.layer.shadowOpacity = 0.3
        footerView.layer.shadowRadius = 8
        footerView.layer.masksToBounds = false

        NSLayoutConstraint.activate([
            footerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 56)
        ])
    }

    private func configureIncreaseDecreaseView() {
        footerView.addSubview(increaseDecreaseView)

        increaseDecreaseView.setup(with: IncreaseDecreaseViewUIModel(
            decreaseButton: SmallIconButtonUIModel(
                icon: "minus",
                backgroundColor: "appDarkGray",
                iconColor: "appLightGray",
                radius: 6),
            count: 1,
            increaseButton: SmallIconButtonUIModel(
                icon: "plus",
                backgroundColor: "primary",
                iconColor: "appLightGray",
                radius: 6)))

        NSLayoutConstraint.activate([
            increaseDecreaseView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -(view.frame.size.width / 4)),
            increaseDecreaseView.centerYAnchor.constraint(equalTo: footerView.centerYAnchor)
        ])
    }

    private func configureAddButton() {
        footerView.addSubview(addButton)
        addButton.setTitle("Add to cart", for: .normal)
        addButton.addTarget(self, action: #selector(addToCartButtontClick), for: .touchUpInside)

        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: (view.frame.size.width / 4)),
            addButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor)
        ])
    }

    @objc private func favoriteButtonClicked() {
        isFavorited.toggle()
        changeFavoriteStatus(with: isFavorited)
        viewModel.changeFavoriteStatus(id: productId)
    }

    private func changeFavoriteStatus(with value: Bool) {
        isFavorited = value

        if isFavorited {
            favoriteBarButton.image = UIImage(systemName: favoriteIcon.favorited.rawValue)
        } else {
            favoriteBarButton.image = UIImage(systemName: favoriteIcon.notFavorited.rawValue)
        }
    }

    @objc private func addToCartButtontClick() {
        viewModel.addToCart(productCount: increaseDecreaseView.count)
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
                changeFavoriteStatus(with: product.isFavorited)
            }

            if let propertiesModel = viewModel.generatePropertiesUIModel() {
                propertiesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
                propertiesStackView.setup(with: propertiesModel)
            }
        case .setLoading(let isLoading):
            setLoading(status: isLoading)
        case .showAlert:
            presentCustomAlert(alertTitle: "Success!", message: "Your product has been added to the cart.", buttonTitle: "OK")
        }
    }
}

extension ProductDetailViewController {
    enum favoriteIcon: String {
        case favorited = "heart.circle.fill"
        case notFavorited = "heart.circle"
    }
}

