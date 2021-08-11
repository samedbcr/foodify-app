//
//  ViewController.swift
//  Foodify
//
//  Created by Samed Biçer on 8.08.2021.
//

import UIKit
import FoodifyAPI

class ViewController: UIViewController {

    private let testView = HorizontalInfoCardView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        configure()
    }

    private func configure() {
        view.addSubview(testView)
        testView.translatesAutoresizingMaskIntoConstraints = false

        let model = HorizontalInfoCardViewUIModel(
            imageWithShadowViewModel: ImageWithShadowViewUIModel(url: "chicken_plate"),
            title: "Chicken Plate",
            description: "Chicken Food",
            increaseDecreaseViewModel: IncreaseDecreaseViewUIModel(
                decreaseButton: SmallIconButtonUIModel(icon: "minus", backgroundColor: "appDarkGray", iconColor: "appLightGray", radius: 12),
                text: "2",
                increaseButton: SmallIconButtonUIModel(icon: "plus", backgroundColor: "primary", iconColor: "appLightGray", radius: 12)),
            extraText: "28$")
        testView.setup(with: model)

        NSLayoutConstraint.activate([
            testView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            testView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testView.widthAnchor.constraint(equalToConstant: view.frame.size.width - 40),
            testView.heightAnchor.constraint(equalToConstant: view.frame.size.width / 3),
        ])
    }

}

