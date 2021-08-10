//
//  CustomButton.swift
//  Foodify
//
//  Created by Samed Biçer on 10.08.2021.
//

import UIKit

final class CustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .primary
        layer.cornerRadius = 22
        titleLabel?.textColor = .appLightGray
        titleLabel?.font = UIFont(name: Fonts.poppinsSemiBold, size: 13)
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
