//
//  TabBarMiddleButton.swift
//  Foodify
//
//  Created by Samed Biçer on 15.08.2021.
//
import UIKit

class TabBarMiddleButton: UIButton {

    private let gradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
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
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .primary
        layer.cornerRadius = 32
        clipsToBounds = true
        contentVerticalAlignment = .fill
        contentHorizontalAlignment = .fill
        imageEdgeInsets = UIEdgeInsets(top: 21, left: 21, bottom: 21, right: 21)
        let buttonImage = UIImage(named: "cart")?.withRenderingMode(.alwaysTemplate)
        setImage(buttonImage, for: .normal)
        tintColor = .white
        bringSubviewToFront(self.imageView!)
    }
}
