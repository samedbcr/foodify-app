//
//  ReceiptEmptyView.swift
//  Foodify
//
//  Created by Samed Biçer on 21.08.2021.
//

import UIKit

class ReceiptEmptyView: UIView {

    let message: String
    let messageLabel = UILabel()

    init(message: String) {
        self.message = message
        super.init(frame: .zero)

        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        configureMessageLabel()
    }

    func configureMessageLabel() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.text = message
        messageLabel.textColor = .appDarkGray
        messageLabel.font = UIFont(name: Fonts.poppinsRegular, size: 14)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        addSubview(messageLabel)

        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
