//
//  IncreaseDecreaseView.swift
//  Foodify
//
//  Created by Samed Biçer on 10.08.2021.
//

import UIKit

final class IncreaseDecreaseView: UIView {
    private let stackView = UIStackView()
    private let increaseButton = SmallIconButton()
    private let decreaseButton = SmallIconButton()
    private let textLabel = UILabel()
    var count = 0 {
        didSet {
            textLabel.text = "\(count)"
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        configureStackView()
        configureTextLabel()
        configureButtons()
    }

    private func configureStackView() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 14

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        stackView.addArrangedSubview(decreaseButton)
        stackView.addArrangedSubview(textLabel)
        stackView.addArrangedSubview(increaseButton)
    }

    private func configureTextLabel() {
        textLabel.font = UIFont(name: Fonts.poppinsSemiBold, size: 14)
        textLabel.textColor = .primary
    }

    private func configureButtons() {
        increaseButton.addTarget(self, action: #selector(increaseButtonClick), for: .touchUpInside)
        decreaseButton.addTarget(self, action: #selector(decreaseButtonClick), for: .touchUpInside)
    }

    func setup(with model: IncreaseDecreaseViewUIModel) {
        increaseButton.setup(with: model.increaseButton)
        decreaseButton.setup(with: model.decreaseButton)
        count = model.count
    }

    @objc func increaseButtonClick() {
        count += 1
    }

    @objc func decreaseButtonClick() {
        if count > 1 {
            count -= 1
        }
    }
}
