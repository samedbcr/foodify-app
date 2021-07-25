//
//  MovieListViewController.swift
//  MovieListingApp
//
//  Created by Samed Biçer on 17.07.2021.
//

import UIKit

final class MovieListViewController: UIViewController {
    var collectionView: UICollectionView!
    let searchController = UISearchController(searchResultsController: nil)
    let barButton = UIBarButtonItem()
    var movies = [Movie]()
    var filteredMovies = [Movie]()
    var hasMorData = true
    var isSearchActive = false
    var page = 1
    var isGridLayout = true

    override func viewDidLoad() {
        super.viewDidLoad()
        let _ = PersistenceManager.shared
        configure()
    }

    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemGray4]
        navigationController?.navigationBar.barStyle = .black
    }

    private func getMovieList(at page: Int) {
        NetworkManager.shared.getMovieList(at: page) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let movies):
                if movies.count < 20 { self.hasMorData = false }
                self.movies.append(contentsOf: self.populateFavoriteStatus(of: movies))
                self.filteredMovies = self.movies
                self.updateData()
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }

    private func populateFavoriteStatus(of movies: [Movie]) -> [Movie] {
        return movies.map { movie -> Movie in
            if PersistenceManager.favoritedMovieIds.contains(movie.id) {
                var mutableMovie = movie
                mutableMovie.isFavorited = true
                return mutableMovie
            }
            return movie
        }
    }

    private func configure() {
        view.backgroundColor = .black
        navigationItem.setRightBarButton(barButton, animated: true)
        configureCollectionView()
        configureSearchController()
        getMovieList(at: page)
    }

    private func configureBarButton() {
        barButton.image = UIImage(systemName: "rectangle.grid.1x2.fill")
        barButton.tintColor = .systemGray3
        barButton.style = .plain
        barButton.target = self
        barButton.action = #selector(changeLayout)
    }

    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: UIHelper.createTwoColumnsFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseId)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func configureSearchController() {
        searchController.searchBar.placeholder = "Search Movie"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = .systemGray3
        searchController.searchBar.barStyle = .black
        navigationItem.searchController = searchController
    }

    private func updateData() {
        DispatchQueue.main.async {
            UIView.performWithoutAnimation {
                self.collectionView.reloadData()
            }
        }
    }

    @objc private func changeLayout() {
        isGridLayout.toggle()
        let layout: UICollectionViewLayout
        if isGridLayout {
            barButton.image = UIImage(systemName: "rectangle.grid.1x2.fill")
            layout = UIHelper.createTwoColumnsFlowLayout(in: view)
        } else {
            barButton.image = UIImage(systemName: "rectangle.grid.2x2.fill")
            layout = UIHelper.createSingleColumnFlowLayout(in: view)
        }

        collectionView.startInteractiveTransition(to: layout, completion: nil)
        collectionView.finishInteractiveTransition()
    }
}

extension MovieListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if filteredMovies.count == 0 {
            collectionView.showEmptyState()
        } else {
            collectionView.restoreFromEmptyState()
        }
        return filteredMovies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseId, for: indexPath) as! MovieCell
        movieCell.set(movie: filteredMovies[indexPath.row])
        return movieCell
    }
}

extension MovieListViewController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height

        if offsetY > contentHeight - height {
            guard hasMorData, !isSearchActive else { return }
            page += 1
            getMovieList(at: page)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destVC = MovieDetailViewController()
        destVC.delegate = self
        destVC.movie = filteredMovies[indexPath.row]
        destVC.listIndex = indexPath.row
        navigationController?.pushViewController(destVC, animated: true)
    }
}

extension MovieListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        if searchText.isEmpty {
            filteredMovies = movies
            isSearchActive = false
        } else {
            filteredMovies = movies.filter { $0.title.lowercased().contains(searchText.lowercased()) }
            isSearchActive = true
        }
        updateData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearchActive = false
    }
}

extension MovieListViewController: MovieFavoriteDelegate {
    func movieFavoriteChanged(to value: Bool, at index: Int) {
        movies[index].isFavorited = value
        filteredMovies[index].isFavorited = value
        updateData()
    }
}

extension UICollectionView {
    func showEmptyState() {
        let emptyStateView = EmptyStateView(message: "Cannot found any movie!", image: "no_data")
        self.backgroundView = emptyStateView
    }

    func restoreFromEmptyState() {
        self.backgroundView = nil
    }
}
