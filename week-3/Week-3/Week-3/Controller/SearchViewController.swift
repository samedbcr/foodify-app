//
//  SearchViewController.swift
//  Week-3
//
//  Created by Samed Biçer on 7.07.2021.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)

    var users = [User]() // original data
    var filteredUsers = [User]() // filteredData after filter original data via searchbar text

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Search"
        fetchData()
        tableView.dataSource = self
        configureSearchController()
    }

    func fetchData() {
        let urlStr = "https://jsonplaceholder.typicode.com/users"
        guard let userURL = URL(string: urlStr) else { return }
        let userList = try? JSONDecoder().decode([User].self, from: Data(contentsOf: userURL))

        guard let users = userList else { return }
        self.users = users
        self.filteredUsers = users
    }

    private func configureSearchController() {
        searchController.searchBar.placeholder = "Search User"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredUsers.count == 0 {
            // Hande no data situations (empty state)
            tableView.showEmptyState()
        } else {
            tableView.restoreFromEmptyState()
        }

        return filteredUsers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell")
        cell?.textLabel?.text = filteredUsers[indexPath.row].name
        cell?.detailTextLabel?.text = filteredUsers[indexPath.row].company.name

        guard let tableCell = cell else { return UITableViewCell() }
        return tableCell
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let searchText = searchBar.text else { return }
        if searchText == "" {
            filteredUsers = users
        } else {
            filteredUsers = users.filter {
                return $0.name.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
}
