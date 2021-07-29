//
//  GameDetailVC.swift
//  VideoGamesApp
//
//  Created by Samed Biçer on 28.07.2021.
//

import UIKit

class GameDetailVC: UIViewController {

    var id: Int?
    let favoriteBarButton = UIBarButtonItem()
    let scrollView = UIScrollView()
    let contentView = UIView()
    let gameImageView = UIImageView()
    let nameLabel = UILabel()
    let stackView = UIStackView()
    let releaseLabel = UILabel()
    let metacriticLabel = UILabel()
    let descriptionLabel = UILabel()
    var game: Game?
    var isFavorited = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationController?.navigationBar.tintColor = .systemRed
        configure()
    }

    private func configure() {
        configureFavoriteBarButton()
        configureScrollView()
        configureContentView()
        configureImageView()
        configureNameLabel()
        configureStackView()
        configureDescriptionLabel()
        checkFavoriteStatus()
        getMovie()
    }

    private func getMovie() {
        presentLoadingView()
        guard let id = id else { return }
        NetworkManager.shared.getMovie(id: id) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let game):
                self.set(game: game)
            case .failure(let error):
                print(error)
            }
        }
    }

    private func configureFavoriteBarButton() {
        let imageName = "star"
        favoriteBarButton.image = UIImage(systemName: imageName)
        favoriteBarButton.tintColor = .systemRed
        favoriteBarButton.style = .plain
        favoriteBarButton.target = self
        favoriteBarButton.action = #selector(favoriteButtonClicked)
        navigationItem.setRightBarButton(favoriteBarButton, animated: true)
    }

    private func configureScrollView() {
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
        contentView.addSubview(gameImageView)
        gameImageView.translatesAutoresizingMaskIntoConstraints = false
        gameImageView.image = UIImage(named: "gaming_console")
        gameImageView.contentMode = .scaleAspectFill
        gameImageView.layer.masksToBounds = true

        NSLayoutConstraint.activate([
            gameImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            gameImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gameImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gameImageView.heightAnchor.constraint(equalToConstant: (view.frame.width * 3) / 4),
        ])
    }

    private func configureNameLabel() {
        scrollView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .preferredFont(forTextStyle: .title2)
        nameLabel.textColor = .systemGray2
        nameLabel.numberOfLines = 0

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: gameImageView.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func configureStackView() {
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 6

        releaseLabel.font = .preferredFont(forTextStyle: .footnote)
        releaseLabel.textColor = .lightText
        releaseLabel.numberOfLines = 0
        stackView.addArrangedSubview(releaseLabel)

        metacriticLabel.font = .preferredFont(forTextStyle: .footnote)
        metacriticLabel.textColor = .lightText
        metacriticLabel.numberOfLines = 0
        metacriticLabel.textAlignment = .right
        stackView.addArrangedSubview(metacriticLabel)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }

    private func configureDescriptionLabel() {
        scrollView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textColor = .lightText
        descriptionLabel.font = .preferredFont(forTextStyle: .body)
        descriptionLabel.numberOfLines = 0

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
        ])
    }

    private func set(game: Game) {
        DispatchQueue.main.async {
            self.game = game
            self.title = game.name
            self.nameLabel.text = game.name
            self.gameImageView.downloadImage(from: game.backgroundImage, placeholder: "gaming_console")
            self.releaseLabel.text = "Release Date: \(game.released)"

            if let description = game.description {
                self.descriptionLabel.text = description.htmlToString
            } else {
                self.descriptionLabel.text = "Game description is not specified."
            }

            if let metacritic = game.metacritic {
                self.metacriticLabel.text = "Metacritic Rate: \(metacritic)"
            }
        }
    }

    private func checkFavoriteStatus() {
        guard let id = id else { return }
        PersistenceManager.favoritedGames.forEach { (game) in
            if game.id == id {
                isFavorited = true
                toggleFavoriteBarButton()
            }
        }
    }

    private func toggleFavoriteBarButton() {
        if isFavorited {
            favoriteBarButton.image = UIImage(systemName: "star.fill")
        } else {
            favoriteBarButton.image = UIImage(systemName: "star")
        }
    }

    @objc func favoriteButtonClicked() {
        guard let game = game else { return }
        if isFavorited {
            PersistenceManager.shared.deleteFromFavorite(gameId: game.id)
        } else {
            PersistenceManager.shared.addToFavorite(game: game)
        }
        isFavorited.toggle()
        toggleFavoriteBarButton()

        // Send notification to listeners (FavoritesVC)
        NotificationCenter.default.post(name: .favoriteChangeNotification, object: nil, userInfo: nil)
    }

}
