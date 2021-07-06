//
//  ViewController.swift
//  Week-3
//
//  Created by Samed Biçer on 6.07.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var users = [User]() // original data
    var filteredUsers = [User]() // filteredData after filter original data via searchbar text

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        tableView.dataSource = self
    }

    func fetchData() {
        let urlStr = "https://jsonplaceholder.typicode.com/users"
        guard let userURL = URL(string: urlStr) else { return }
        let userList = try? JSONDecoder().decode([User].self, from: Data(contentsOf: userURL))

        guard let users = userList else { return }
        self.users = users
        self.filteredUsers = users
    }
}

extension ViewController: UITableViewDataSource {
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

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            filteredUsers = users
        } else {
            filteredUsers = users.filter {
                return $0.name.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredUsers = users
        searchBar.text = ""
        tableView.reloadData()
    }
}

extension UITableView {
    func showEmptyState() {
        let emptyStateView = EmptyStateView(message: "Cannot found any user!", image: "not_found")
        self.backgroundView = emptyStateView
        self.separatorStyle = .none
    }

    func restoreFromEmptyState() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
