//
//  ViewController.swift
//  Foodify
//
//  Created by Samed Biçer on 8.08.2021.
//

import UIKit
import FoodifyAPI

class ViewController: UIViewController {

    private let testView = IncreaseDecreaseView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        configure()
    }

    private func configure() {
        view.addSubview(testView)
        testView.translatesAutoresizingMaskIntoConstraints = false

        let model = IncreaseDecreaseViewUIModel(
            increaseButton: SmallIconButtonUIModel(icon: "minus", backgroundColor: "appDarkGray", iconColor: "appLightGray", radius: 12),
            decreaseButton: SmallIconButtonUIModel(icon: "plus", backgroundColor: "primary", iconColor: "appLightGray", radius: 12),
            text: "4")
        testView.setup(with: model)

        NSLayoutConstraint.activate([
            testView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            testView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
        ])
    }

}

