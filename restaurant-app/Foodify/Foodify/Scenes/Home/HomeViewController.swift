//
//  HomeViewController.swift
//  Foodify
//
//  Created by Samed Biçer on 12.08.2021.
//

import UIKit

class HomeViewController: UIViewController {

    var viewModel: HomeViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .cyan
        viewModel.load()
    }

}

extension HomeViewController: HomeViewModelDelegate {
    func handleViewOutput(_ output: HomeViewModelOutput) {
        switch output {
        case .reloadCategoryList:
            print("reload category list")
        case .setLoading(let isLoading):
            print(isLoading)
        }
    }


}
