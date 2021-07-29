//
//  EmptyStateView.swift
//  VideoGamesApp
//
//  Created by Samed Biçer on 28.07.2021.
//

import UIKit

class EmptyStateView: UIView {

    let message: String
    let image: String
    let messageLabel = UILabel()
    let imageView = UIImageView()

    init(message: String, image: String) {
        self.message = message
        self.image = image
        super.init(frame: .zero)

        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        configureImageView()
        configureMessageLabel()
    }

    func configureImageView() {
        guard let image = UIImage(named: image) else { return }
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -40),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            imageView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }

    func configureMessageLabel() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.text = message
        messageLabel.textColor = .lightText
        messageLabel.font = .boldSystemFont(ofSize: 18)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        addSubview(messageLabel)

        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}

