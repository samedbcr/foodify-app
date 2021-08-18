//
//  CartViewController.swift
//  Foodify
//
//  Created by Samed Biçer on 17.08.2021.
//

import UIKit

class CartViewController: UIViewController {
    let favoriteBarButton = UIBarButtonItem()
    private var productsCollectionView: UICollectionView!
    private var receiptCollectionView: UICollectionView!
    private let bottomContainerView = UIView()
    private let receiptTitleLabel = UILabel()
    private let totalRowView = BasicTableRowView()
    private let checkoutButton = CustomButton()

    var viewModel: CartViewModelProtocol! {
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
        view.backgroundColor = .white
        title = "Cart"
        tabBarItem.title = ""
        configureFavoriteBarButton()
        configureProductCollectionView()
        configureBottomContainerView()
        configureTitleLabel()
        configureCheckoutButton()
        configureTotalRowView()
        configureReceiptCollectionView()
    }

    private func configureFavoriteBarButton() {
        let imageName = "trash"
        favoriteBarButton.image = UIImage(systemName: imageName)
        favoriteBarButton.tintColor = .primary
        favoriteBarButton.style = .plain
        favoriteBarButton.target = self
//        favoriteBarButton.action = #selector(favoriteButtonClicked)
        navigationItem.setRightBarButton(favoriteBarButton, animated: true)
    }

    private func configureProductCollectionView() {
        productsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createSingleColumnsFlowLayout(in: view))
        view.addSubview(productsCollectionView)
        productsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        productsCollectionView.showsVerticalScrollIndicator = false
        productsCollectionView.backgroundColor = .white
        productsCollectionView.register(HorizontalProductCell.self, forCellWithReuseIdentifier: HorizontalProductCell.reuseId)
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self

        NSLayoutConstraint.activate([
            productsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            productsCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            productsCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            productsCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.58)
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
            bottomContainerView.topAnchor.constraint(equalTo: productsCollectionView.bottomAnchor, constant: -30),
            bottomContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func configureTitleLabel() {
        bottomContainerView.addSubview(receiptTitleLabel)
        receiptTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        receiptTitleLabel.text = "Selected Food"
        receiptTitleLabel.font = UIFont(name: Fonts.poppinsSemiBold, size: 16)
        receiptTitleLabel.textColor = .appDark

        NSLayoutConstraint.activate([
            receiptTitleLabel.topAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: 12),
            receiptTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            receiptTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])
    }

    private func configureCheckoutButton() {
        bottomContainerView.addSubview(checkoutButton)
        checkoutButton.setTitle("Checkout", for: .normal)

        NSLayoutConstraint.activate([
            checkoutButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66),
            checkoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }

    private func configureTotalRowView() {
        bottomContainerView.addSubview(totalRowView)
        let model = BasicTableRowViewUIModel(leadingText: "Total", trailingText: "$120", isBigText: true)
        totalRowView.setup(with: model)

        NSLayoutConstraint.activate([
            totalRowView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            totalRowView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            totalRowView.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor, constant: -12)
        ])
    }

    private func configureReceiptCollectionView() {
        receiptCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createBasicTableViewFlowLayout(in: view))
        bottomContainerView.addSubview(receiptCollectionView)
        receiptCollectionView.translatesAutoresizingMaskIntoConstraints = false
        receiptCollectionView.showsVerticalScrollIndicator = false
        receiptCollectionView.backgroundColor = .white
        receiptCollectionView.register(ReceiptCell.self, forCellWithReuseIdentifier: ReceiptCell.reuseId)
        receiptCollectionView.delegate = self
        receiptCollectionView.dataSource = self

        NSLayoutConstraint.activate([
            receiptCollectionView.topAnchor.constraint(equalTo: receiptTitleLabel.bottomAnchor),
            receiptCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            receiptCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            receiptCollectionView.bottomAnchor.constraint(equalTo: totalRowView.topAnchor, constant: -10)
        ])
    }

}

extension CartViewController: CartViewModelDelegate {
    func handleViewOutput(_ output: CartViewModelOutput) {
        switch output {
        case .reload:
            productsCollectionView.reloadData()
            receiptCollectionView.reloadData()
            totalRowView.changeTrailingLabel(with: "$\(viewModel.totalPrice)")
        case .setLoading(let isLoading):
            print(isLoading)
        }
    }
}

extension CartViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.cartCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let product = viewModel.cart[indexPath.row]

        // Product Collection View
        if collectionView == productsCollectionView {
            let cell = productsCollectionView.dequeueReusableCell(withReuseIdentifier: HorizontalProductCell.reuseId, for: indexPath) as! HorizontalProductCell
            let model = HorizontalInfoCardViewUIModel(
                imageWithShadowViewModel: ImageWithShadowViewUIModel(url: product.imagePath),
                title: product.productName,
                description: product.categoryName,
                increaseDecreaseViewModel: IncreaseDecreaseViewUIModel(
                    decreaseButton: SmallIconButtonUIModel(icon: "minus", backgroundColor: "appDarkGray", iconColor: "appLightGray", radius: 12),
                    text: product.count.description,
                    increaseButton: SmallIconButtonUIModel(icon: "plus", backgroundColor: "primary", iconColor: "appLightGray", radius: 12)),
                extraText: "$\(Int(product.price))")
            cell.setup(with: model)
            return cell
        }

        // Receipt Collection View
        let cell = receiptCollectionView.dequeueReusableCell(withReuseIdentifier: ReceiptCell.reuseId, for: indexPath) as! ReceiptCell
        let model = BasicTableRowViewUIModel(leadingText: product.productName, trailingText: "$\(Int(product.price))", isBigText: false)
        cell.setup(with: model)
        return cell
    }
}
