//
//  ViewController.swift
//  Foodify
//
//  Created by Samed Biçer on 8.08.2021.
//

import UIKit
import FoodifyAPI

class ViewController: UIViewController {

    private let testView = CustomTextField()
    private let testButton = CustomButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        configure()
    }

    private func configure() {
        view.addSubview(testView)
        testView.translatesAutoresizingMaskIntoConstraints = false

        let model = CustomTextFieldUIModel(placeholder: "Credit Card", iconName: "creditcard")
        testView.setup(with: model)

        NSLayoutConstraint.activate([
            testView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            testView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testView.widthAnchor.constraint(equalToConstant: view.frame.size.width - 64),
//            testView.heightAnchor.constraint(equalToConstant: view.frame.size.width / 3),
        ])
        
        configureTestButton()
    }

    private func configureTestButton() {
        view.addSubview(testButton)
        testButton.setTitle("Test it ", for: .normal)
        testButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            testButton.topAnchor.constraint(equalTo: testView.bottomAnchor, constant: 40),
            testButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testButton.widthAnchor.constraint(equalToConstant: view.frame.size.width - 64),
        ])
    }
    
    @objc private func buttonTapped() {
        self.presentCustomAlert(alertTitle: "Succeed!", message: "Your order is taken successfully. Enjoy with your meal. Don't forget to rate it after you taste it!", buttonTitle: "OK")
    }

}

