//
//  ViewController.swift
//  Foodify
//
//  Created by Samed Biçer on 8.08.2021.
//

import UIKit
import FoodifyAPI

class ViewController: UIViewController {

    private let testView = VerticalInfoCardView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        configure()
    }

    private func configure() {
        view.addSubview(testView)
        testView.translatesAutoresizingMaskIntoConstraints = false

        let model = VerticalInfoCardViewUIModel(
            imageWithShadowViewModel: ImageWithShadowViewUIModel(url: "chicken_plate"),
            title: "Chicken Meal",
            ratingStarsViewModel: RatingStarsViewUIModel(count: 3),
            extraText: "20$")
        testView.setup(with: model)

        NSLayoutConstraint.activate([
            testView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            testView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            testView.widthAnchor.constraint(equalToConstant: (view.frame.size.width / 2) - 30),
            testView.heightAnchor.constraint(equalToConstant: (view.frame.size.width / 2) - 30),
        ])
    }

}

