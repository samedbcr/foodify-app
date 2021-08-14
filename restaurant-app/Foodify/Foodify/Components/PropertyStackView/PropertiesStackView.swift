//
//  PropertiesStackView.swift
//  Foodify
//
//  Created by Samed Biçer on 14.08.2021.
//

import UIKit

final class PropertiesStackView: UIStackView {
    private let firstProperty = PropertyView()
    private let secondProperty = PropertyView()
    private let thirdProperty = PropertyView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .horizontal
        distribution = .fillEqually
        alignment = .top
        spacing = 0
    }

    private func generateView(with model: PropertyViewUIModel) {
        let container = UIView()
//        container.backgroundColor = UIColor(red: CGFloat(Double.random(in: 0...1)), green: CGFloat(Double.random(in: 0...1)), blue: CGFloat(Double.random(in: 0...1)), alpha: 1)

        let propertyView = PropertyView()
//        propertyView.backgroundColor = UIColor(red: CGFloat(Double.random(in: 0...1)), green: CGFloat(Double.random(in: 0...1)), blue: CGFloat(Double.random(in: 0...1)), alpha: 1)
        propertyView.setup(with: model)
        container.addSubview(propertyView)

        NSLayoutConstraint.activate([
            propertyView.topAnchor.constraint(equalTo: container.topAnchor),
            propertyView.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8),
            propertyView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            propertyView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
        ])

        addArrangedSubview(container)
        container.addLeadingBorder(color: .appLightGray, width: 1)
        container.addTrailingBorder(color: .appLightGray, width: 1)
    }

    private func removeAllArrangedSubviews() {
        // Removes all arranged subviews from StackView
        arrangedSubviews.forEach { view in
            removeArrangedSubview(view)
        }
    }

    func setup(with model: PropertiesStackViewUIModel) {
        removeAllArrangedSubviews()

        model.properties.forEach { model in
            generateView(with: model)
        }
    }


}
