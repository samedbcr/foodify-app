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
    private let customButton = CustomButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        configure()
    }

    private func configure() {
        view.addSubview(testView)
        view.addSubview(customButton)
        testView.translatesAutoresizingMaskIntoConstraints = false
//        customButton.translatesAutoresizingMaskIntoConstraints = false
        customButton.setTitle("Add to cart", for: .normal)

        let model = IncreaseDecreaseViewUIModel(
            increaseButton: SmallIconButtonUIModel(icon: "minus", backgroundColor: "appDarkGray", iconColor: "appLightGray", radius: 12),
            decreaseButton: SmallIconButtonUIModel(icon: "plus", backgroundColor: "primary", iconColor: "appLightGray", radius: 12),
            text: "4")
        testView.setup(with: model)

        NSLayoutConstraint.activate([
            testView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            testView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            customButton.topAnchor.constraint(equalTo: testView.bottomAnchor, constant: 20),
            customButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
        ])
    }

}

