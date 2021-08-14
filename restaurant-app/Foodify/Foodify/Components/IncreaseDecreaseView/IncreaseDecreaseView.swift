//
//  IncreaseDecreaseView.swift
//  Foodify
//
//  Created by Samed Biçer on 10.08.2021.
//

import UIKit

final class IncreaseDecreaseView: UIView {
    let stackView = UIStackView()
    let increaseButton = SmallIconButton()
    let decreaseButton = SmallIconButton()
    let textLabel = UILabel()

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

    func setup(with model: IncreaseDecreaseViewUIModel) {
        increaseButton.setup(with: model.increaseButton)
        decreaseButton.setup(with: model.decreaseButton)
        textLabel.text = model.text
    }
}
