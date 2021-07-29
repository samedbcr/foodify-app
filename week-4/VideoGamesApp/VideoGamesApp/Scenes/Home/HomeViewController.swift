//
//  HomeViewController.swift
//  VideoGamesApp
//
//  Created by Samed Biçer on 26.07.2021.
//

import UIKit

final class HomeViewController: UIViewController {
    var collectionView: UICollectionView!
    let searchController = UISearchController(searchResultsController: nil)
    let gamesPageVC = GamesPageVC()
    let stackView = UIStackView()
    var games = [Game]()
    var filteredGames = [Game]()
    var hasMorData = true
    var isSearchActive = false
    var page = 1


    override func viewDidLoad() {
        super.viewDidLoad()
        let _ = PersistenceManager.shared
        configure()
    }

    private func configure() {
        view.backgroundColor = .black
        configureSearchController()
        configureStackView()
        configureGamesPageVC()
        configureCollectionView()
        getGameList(at: page)
    }

    private func getGameList(at page: Int) {
        presentLoadingView()
        NetworkManager.shared.getMovieList(at: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let games):
                if games.count < 20 { self.hasMorData = false }
                self.games.append(contentsOf: games)
                self.filteredGames = self.games
                self.updateData()
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }

    private func configureSearchController() {
        searchController.searchBar.placeholder = "Search Game"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = .systemGray3
        searchController.searchBar.barStyle = .black
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }

    private func configureStackView() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 6

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    private func configureGamesPageVC() {
        view.addSubview(gamesPageVC.view)
        gamesPageVC.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            gamesPageVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            gamesPageVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            gamesPageVC.view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66)
        ])

        stackView.addArrangedSubview(gamesPageVC.view)
    }

    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createSingleColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(GameCell.self, forCellWithReuseIdentifier: GameCell.reuseId)
        collectionView.delegate = self
        collectionView.dataSource = self

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: gamesPageVC.view.bottomAnchor, constant: 4),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 12)
        ])

        stackView.addArrangedSubview(collectionView)
    }

    private func updateData() {
        DispatchQueue.main.async {
            UIView.performWithoutAnimation {
                self.handleDesign()
                self.collectionView.reloadData()
            }
        }
    }

    private func handleDesign() {
        /**
         Handles design according to Search Text count.
         If SearchText count >= 3, this method removes PageView on the top.
         */
        if isSearchActive {
            gamesPageVC.view.isHidden = true
        } else {
            gamesPageVC.view.isHidden = false
            self.gamesPageVC.populatePageVCs(game: Array(self.filteredGames.prefix(3)))
            self.filteredGames = Array(filteredGames.suffix(filteredGames.count - 3))
        }
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if filteredGames.count == 0 && isSearchActive {
            collectionView.showEmptyState()
        } else {
            collectionView.restoreFromEmptyState()
        }
        return filteredGames.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let gameCell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCell.reuseId, for: indexPath) as! GameCell
        gameCell.set(game: filteredGames[indexPath.row])
        return gameCell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destVC = GameDetailVC()
        destVC.id = filteredGames[indexPath.row].id
        navigationController?.pushViewController(destVC, animated: true)

    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height

        if offsetY > contentHeight - height {
            guard hasMorData, !isSearchActive else { return }
            page += 1
            getGameList(at: page)
        }
    }
}

extension HomeViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        if searchText.isEmpty || searchText.count < 3 {
            if isSearchActive {
                updateData()
            }
            filteredGames = games
            isSearchActive = false
        } else if searchText.count >= 3 {
            filteredGames = games.filter { $0.name.lowercased().contains(searchText.lowercased()) }
            isSearchActive = true
            updateData()
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearchActive = false
        updateData()
    }
}
