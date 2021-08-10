//
//  ImageWithShadowView.swift
//  Foodify
//
//  Created by Samed Biçer on 10.08.2021.
//

import UIKit

final class ImageWithShadowView: UIView {
    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        configureShadow()
        configureImageView()
    }

    private func configureShadow() {
        backgroundColor = .clear
        layer.shadowColor = UIColor.appDarkGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.6
        layer.shadowRadius = 10
        layer.masksToBounds = false
    }

    private func configureImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.heightAnchor.constraint(equalTo: widthAnchor),
        ])
    }

    func setup(with model: ImageWithShadowViewUIModel) {
        imageView.image = UIImage(named: model.url)
    }

}
