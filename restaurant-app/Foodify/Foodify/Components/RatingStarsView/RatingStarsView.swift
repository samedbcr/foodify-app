//
//  RatingStarsView.swift
//  Foodify
//
//  Created by Samed Biçer on 10.08.2021.
//

import UIKit

final class RatingStarsView: UIView {
    let stackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        configureStackView()
    }

    private func configureStackView() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.frame = bounds
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 2
    }

    func setup(with model: RatingStarsViewUIModel) {
        populateStarImageViews(count: model.count)
    }

    private func generateStarImageView(with color: UIColor) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = color

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 10),
            imageView.heightAnchor.constraint(equalToConstant: 10),
        ])

        return imageView
    }

    private func populateStarImageViews(count: Int) {
        let emptyStarCount = 5 - count

        for _ in 0..<count {
            stackView.addArrangedSubview(generateStarImageView(with: .appYellow))
        }

        for _ in 0..<emptyStarCount {
            stackView.addArrangedSubview(generateStarImageView(with: .appDarkGray))
        }
    }
}
