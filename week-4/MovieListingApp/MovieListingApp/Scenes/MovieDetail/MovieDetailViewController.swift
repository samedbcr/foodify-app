//
//  MovieDetailViewController.swift
//  MovieListingApp
//
//  Created by Samed Biçer on 23.07.2021.
//

import UIKit

class MovieDetailViewController: UIViewController {
    var movie: Movie?
    var delegate: MovieFavoriteDelegate?
    var listIndex = 0 // indexPath.row at collectionView
    let favoriteBarButton = UIBarButtonItem()
    let scrollView = UIScrollView()
    let contentView = UIView()
    let movieImageView = UIImageView()
    let aboutLabel = UILabel()
    let movieOverviewLabel = UILabel()
    let stackView = UIStackView()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = movie?.title
        navigationController?.navigationBar.tintColor = .systemGray4
        configure()
    }

    private func configure() {
        configureFavoriteBarButton()
        configureScrollVeiw()
        configureContentView()
        configureImageView()
        configureAboutLabel()
        configureMovieOverviewLabel()
        configureStackView()
    }

    private func configureFavoriteBarButton() {
        guard let movie = movie else { return }
        let imageName = movie.isFavorited ? "star.fill" : "star"
        favoriteBarButton.image = UIImage(systemName: imageName)
        favoriteBarButton.tintColor = .systemGray3
        favoriteBarButton.style = .plain
        favoriteBarButton.target = self
        favoriteBarButton.action = #selector(favoriteButtonClicked)
        navigationItem.setRightBarButton(favoriteBarButton, animated: true)
    }

    private func configureScrollVeiw() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func configureContentView() {
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }

    private func configureImageView() {
        guard let image = movie?.posterPath else { return }
        contentView.addSubview(movieImageView)
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.downloadImage(from: image, with: 400, placeholder: "movie_night")
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.layer.masksToBounds = true

        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieImageView.heightAnchor.constraint(equalToConstant: (view.frame.width * 4) / 3),
        ])
    }

    private func configureAboutLabel() {
        scrollView.addSubview(aboutLabel)
        aboutLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutLabel.text = "About"
        aboutLabel.font = .preferredFont(forTextStyle: .title3)
        aboutLabel.textColor = .systemGray2
        aboutLabel.numberOfLines = 0

        NSLayoutConstraint.activate([
            aboutLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 10),
            aboutLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            aboutLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            aboutLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func configureMovieOverviewLabel() {
        scrollView.addSubview(movieOverviewLabel)
        movieOverviewLabel.translatesAutoresizingMaskIntoConstraints = false
        movieOverviewLabel.text = movie?.overview
        movieOverviewLabel.textColor = .lightText
        movieOverviewLabel.font = .preferredFont(forTextStyle: .body)
        movieOverviewLabel.numberOfLines = 0

        NSLayoutConstraint.activate([
            movieOverviewLabel.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 6),
            movieOverviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            movieOverviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }

    private func configureStackView() {
        guard let movie = movie else { return }
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .top
        stackView.spacing = 8

        let releaseDateLabel = UILabel()
        releaseDateLabel.text = movie.releaseDate ?? "-"
        releaseDateLabel.font = .preferredFont(forTextStyle: .footnote)
        releaseDateLabel.textColor = .lightText
        releaseDateLabel.numberOfLines = 0
        stackView.addArrangedSubview(releaseDateLabel)

        let voteAverageLabel = UILabel()
        voteAverageLabel.text = "Avg.: \(movie.voteAverage)"
        voteAverageLabel.font = .preferredFont(forTextStyle: .footnote)
        voteAverageLabel.textColor = .lightText
        voteAverageLabel.numberOfLines = 0
        voteAverageLabel.textAlignment = .right
        stackView.addArrangedSubview(voteAverageLabel)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: movieOverviewLabel.bottomAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    @objc func favoriteButtonClicked() {
        guard let movie = movie else { return }
        if movie.isFavorited {
            PersistenceManager.shared.deleteFromFavorite(movieId: movie.id)
            favoriteBarButton.image = UIImage(systemName: "star")
            delegate?.movieFavoriteChanged(to: false, at: listIndex)
        } else {
            PersistenceManager.shared.addToFavorite(movieId: movie.id)
            favoriteBarButton.image = UIImage(systemName: "star.fill")
            delegate?.movieFavoriteChanged(to: true, at: listIndex)
        }
        self.movie?.isFavorited.toggle()
    }
}
