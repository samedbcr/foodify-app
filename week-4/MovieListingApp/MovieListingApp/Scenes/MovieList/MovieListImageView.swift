//
//  MovieListImageView.swift
//  MovieListingApp
//
//  Created by Samed Biçer on 18.07.2021.
//

import UIKit

final class MovieListImageView: UIImageView {
    private let movieTitleLabel = UILabel()
    private let favoriteButton = UIButton()
    private var movie: Movie?

    func set(movie: Movie) {
        self.movie = movie
        movieTitleLabel.text = movie.title
        configure()
    }

    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFill

        configureBlurEffectView()
        configureMovieTitleLabel()
        configureFavoriteButton()
    }

    private func configureBlurEffectView() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(blurEffectView)

        NSLayoutConstraint.activate([
            blurEffectView.bottomAnchor.constraint(equalTo: bottomAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurEffectView.heightAnchor.constraint(equalToConstant: 30),
        ])
    }

    private func configureMovieTitleLabel() {
        addSubview(movieTitleLabel)
        movieTitleLabel.font = .boldSystemFont(ofSize: 16)
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        movieTitleLabel.textAlignment = .center
        movieTitleLabel.numberOfLines = 1

        NSLayoutConstraint.activate([
            movieTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            movieTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            movieTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
        ])
    }

    private func configureFavoriteButton() {
        addSubview(favoriteButton)
        var favoriteButtonImage = UIImage(systemName: "star")

        if let movie = self.movie, movie.isFavorited {
            favoriteButtonImage = UIImage(systemName: "star.fill")
        }

        favoriteButton.setImage(favoriteButtonImage, for: .normal)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.contentVerticalAlignment = .fill
        favoriteButton.contentHorizontalAlignment = .fill

        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
            favoriteButton.heightAnchor.constraint(equalToConstant: 28),
            favoriteButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}
