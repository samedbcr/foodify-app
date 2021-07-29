//
//  FavoritesViewController.swift
//  VideoGamesApp
//
//  Created by Samed Biçer on 26.07.2021.
//

import UIKit

class FavoritesViewController: UIViewController {

    var collectionView: UICollectionView!
    var games = [Game]()
    let notificationCenter = NotificationCenter.default

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configure()
        notificationCenter.addObserver(self, selector: #selector(getFavorites), name: .favoriteChangeNotification, object: nil)
    }

    private func configure() {
        configureCollectionView()
        getFavorites()
    }

    @objc private func getFavorites() {
        games = PersistenceManager.favoritedGames
        collectionView.reloadData()
    }

    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createSingleColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(GameCell.self, forCellWithReuseIdentifier: GameCell.reuseId)
        collectionView.delegate = self
        collectionView.dataSource = self

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }

}

extension FavoritesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if games.count == 0 {
            collectionView.showEmptyState()
        } else {
            collectionView.restoreFromEmptyState()
        }
        return games.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let gameCell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCell.reuseId, for: indexPath) as! GameCell
        gameCell.set(game: games[indexPath.row])
        return gameCell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destVC = GameDetailVC()
        destVC.id = games[indexPath.row].id
        navigationController?.pushViewController(destVC, animated: true)
    }
}
