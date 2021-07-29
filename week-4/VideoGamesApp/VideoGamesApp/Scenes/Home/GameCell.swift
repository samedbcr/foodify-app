//
//  GameCell.swift
//  VideoGamesApp
//
//  Created by Samed Biçer on 26.07.2021.
//

import UIKit

class GameCell: UICollectionViewCell {
    static let reuseId = "GameCell"
    let stackView = UIStackView()
    let gameImageView = UIImageView()
    let labelStackView = UIStackView()
    let gameTitleLabel = UILabel()
    let gameInfoLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(game: Game) {
        gameTitleLabel.text = game.name
        gameInfoLabel.text = "\(game.rating) - \(game.released)"
        gameImageView.downloadImage(from: game.backgroundImage, placeholder: "gaming_console")
    }

    private func configure() {
        configureStackView()
        configureImageView()
        configureLabelStackView()
        configureGameTitleLabel()
        configureGameInfoLabel()
    }

    private func configureStackView() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 12

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        ])
    }

    private func configureImageView() {
        addSubview(gameImageView)
        gameImageView.translatesAutoresizingMaskIntoConstraints = false
        gameImageView.clipsToBounds = true
        gameImageView.contentMode = .scaleAspectFill

        NSLayoutConstraint.activate([
            gameImageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1.5),
        ])

        stackView.addArrangedSubview(gameImageView)
    }

    private func configureLabelStackView() {
        labelStackView.axis = .vertical
        labelStackView.distribution = .fill
        labelStackView.alignment = .leading
        labelStackView.spacing = 6

        stackView.addArrangedSubview(labelStackView)
    }

    private func configureGameTitleLabel() {
        gameTitleLabel.text = "God of War"
        gameTitleLabel.font = .preferredFont(forTextStyle: .headline)
        gameTitleLabel.textColor = .systemGray6

        labelStackView.addArrangedSubview(gameTitleLabel)
    }

    private func configureGameInfoLabel() {
        gameInfoLabel.text = "8.5 - 22 May"
        gameInfoLabel.font = .preferredFont(forTextStyle: .subheadline)
        gameInfoLabel.textColor = .systemGray2

        labelStackView.addArrangedSubview(gameInfoLabel)
    }
}
