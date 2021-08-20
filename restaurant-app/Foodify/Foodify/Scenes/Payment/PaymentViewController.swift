//
//  PaymentViewController.swift
//  Foodify
//
//  Created by Samed Biçer on 19.08.2021.
//

import UIKit

final class PaymentViewController: UIViewController {
    private let imageView = UIImageView()
    private let confirmButton = CustomButton()
    private let cardHolderTextField = CustomTextField()
    private let cardNumberTextField = CustomTextField()
    private let expireDateTextField = CustomTextField()
    private let cvvTextField = CustomTextField()
    private let stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        createDismissKeyboardTapGesture()
    }

    private func configure() {
        view.backgroundColor = .white
        configureImageView()
        configureConfirmButton()
        configureCardHolderTextField()
        configureCardNumberTextField()
        configureStackView()
        configureExpireDateTextField()
        configureCvvTextField()
    }

    private func configureImageView() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        guard let image = UIImage(named: "payment") else { return }
        imageView.image = image
        let imageRatio = image.size.width / image.size.height
        imageView.contentMode = .scaleAspectFit

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1 / imageRatio)
        ])
    }

    private func configureConfirmButton() {
        view.addSubview(confirmButton)
        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.addTarget(self, action: #selector(checkoutButtonClick), for: .touchUpInside)

        NSLayoutConstraint.activate([
            confirmButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66),
            confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }

    private func configureCardHolderTextField() {
        view.addSubview(cardHolderTextField)
        let model = CustomTextFieldUIModel(placeholder: "Card Holder", iconName: "person.fill", keyboardType: .default)
        cardHolderTextField.setup(with: model)
        cardHolderTextField.delegate = self

        NSLayoutConstraint.activate([
            cardHolderTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            cardHolderTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66),
            cardHolderTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func configureCardNumberTextField() {
        view.addSubview(cardNumberTextField)
        let model = CustomTextFieldUIModel(placeholder: "Card Number", iconName: "creditcard.fill", keyboardType: .numbersAndPunctuation)
        cardNumberTextField.setup(with: model)
        cardNumberTextField.delegate = self

        NSLayoutConstraint.activate([
            cardNumberTextField.topAnchor.constraint(equalTo: cardHolderTextField.bottomAnchor, constant: 20),
            cardNumberTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66),
            cardNumberTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func configureStackView() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 12

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: cardNumberTextField.bottomAnchor, constant: 20),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func configureExpireDateTextField() {
        let model = CustomTextFieldUIModel(placeholder: "Expire Date", iconName: "calendar", keyboardType: .numbersAndPunctuation)
        expireDateTextField.setup(with: model)
        expireDateTextField.delegate = self

        stackView.addArrangedSubview(expireDateTextField)
    }

    private func configureCvvTextField() {
        let model = CustomTextFieldUIModel(placeholder: "CVV", iconName: "lock.fill", keyboardType: .numberPad)
        cvvTextField.setup(with: model)
        cvvTextField.delegate = self

        stackView.addArrangedSubview(cvvTextField)
    }

    @objc private func checkoutButtonClick() {
        setDummyLoading()
    }

    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }

    private func setDummyLoading() {
        setLoading(status: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.setLoading(status: false)
            self.presentCustomAlert(alertTitle: "Succeed! ✅", message: "Your order has been received successfully. Enjoy your meal!", buttonTitle: "OK")
        }
    }
}

extension PaymentViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
