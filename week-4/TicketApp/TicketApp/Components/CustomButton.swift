//
//  CustomButton.swift
//  TicketApp
//
//  Created by Samed Biçer on 30.07.2021.
//

import UIKit

class CustomButton: UIButton {
    private let gradientLayer = CAGradientLayer()

    init(title: String) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    private func configure() {
        setupGradient()
//        clipsToBounds = true
        layer.cornerRadius = 6
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont(name: Fonts.poppinsMedium, size: 14)
        translatesAutoresizingMaskIntoConstraints = false
    }

    func setupGradient() {
        let firstColor = UIColor.primaryLight
        let secondColor = UIColor.primaryDark
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.cornerRadius = 6

        gradientLayer.shadowColor = UIColor.black.cgColor
        gradientLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        gradientLayer.shadowRadius = 5.0
        gradientLayer.shadowOpacity = 0.3
        gradientLayer.masksToBounds = false

        layer.insertSublayer(gradientLayer, at: 0)
    }

}
