//
//  FirstPageVC.swift
//  Week-3
//
//  Created by Samed Biçer on 7.07.2021.
//

import UIKit

class SecondPageVC: UIViewController {

    let customView = EmptyStateView(message: "We are happy to see you!", image: "celebrating")

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {
        configureCustomStateView()
    }

    func configureCustomStateView() {
        view.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            customView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
