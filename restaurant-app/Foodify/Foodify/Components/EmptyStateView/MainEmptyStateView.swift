//
//  MainEmptyStateView.swift
//  Foodify
//
//  Created by Samed Biçer on 21.08.2021.
//

import UIKit

class MainEmptyStateView: UIView {

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
        let imageRatio = image.size.width / image.size.height
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -40),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.66),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1 / imageRatio)
        ])
    }

    func configureMessageLabel() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.text = message
        messageLabel.textColor = .appDarkGray
        messageLabel.font = UIFont(name: Fonts.poppinsMedium, size: 16)
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
