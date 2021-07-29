//
//  GameCarouselVC.swift
//  VideoGamesApp
//
//  Created by Samed Biçer on 28.07.2021.
//

import UIKit

final class GameCarouselVC: UIViewController {

    var imageView = UIImageView()
    var imageUrl: String?
    var gameId: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "gaming_console")

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)

        if let imageUrl = imageUrl {
            imageView.downloadImage(from: imageUrl, placeholder: "gaming_console")
        }

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    @objc private func imageTapped() {
        guard let id = gameId else { return }
        let destVC = GameDetailVC()
        destVC.id = id
        present(destVC, animated: true, completion: nil)
    }

}
