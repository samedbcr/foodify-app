//
//  MovieCell.swift
//  MovieListingApp
//
//  Created by Samed Biçer on 18.07.2021.
//

import UIKit

class MovieCell: UICollectionViewCell {
    static let reuseId = "MovieCell"

    let movieImage = MovieListImageView(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(movie: Movie) {
        movieImage.set(movie: movie)
        movieImage.downloadImage(from: movie.posterPath, with: 200, placeholder: "movie_night")
        configure()
    }

    private func configure() {
        backgroundColor = .black
        layer.shadowColor = UIColor.systemGray2.cgColor
        layer.shadowOpacity = 0.6
        layer.shadowOffset = .zero
        layer.shadowRadius = 8
        layer.masksToBounds = false

        addSubview(movieImage)
        movieImage.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
