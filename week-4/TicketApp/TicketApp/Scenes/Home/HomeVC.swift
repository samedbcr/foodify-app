//
//  ViewController.swift
//  TicketApp
//
//  Created by Samed Biçer on 29.07.2021.
//

import UIKit

final class HomeVC: UIViewController {

    private let gradientLayer = CAGradientLayer()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let fromTextField = CustomTextField(placeholder: "From", rightIcon: UIImage(systemName: "mappin"))
    private let toTextField = CustomTextField(placeholder: "To", rightIcon: UIImage(systemName: "map"))
    private let whenTextField = CustomTextField(placeholder: "When", rightIcon: UIImage(systemName: "calendar"))
    private let searchButton = CustomButton(backgroundColor: .brown, title: "Search")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradient()
        configure()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradientLayer.frame = view.bounds
    }

    private func setupGradient() {
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.systemGray6.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)

        gradientLayer.shadowColor = UIColor.black.cgColor
        gradientLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        gradientLayer.shadowRadius = 5.0
        gradientLayer.shadowOpacity = 0.3
        gradientLayer.masksToBounds = false

        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func configure() {
        configureImageView()
        configureTitleLabel()
        configureFromTextField()
        configureToTextField()
        configureWhenTextField()
        configureSearchButton()
    }

    private func configureImageView() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        guard let image = UIImage(named: "aircraft") else { return }
        let imageRatio = image.size.width / image.size.height
        imageView.image = image
        imageView.contentMode = .scaleAspectFill

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1 / imageRatio)
        ])
    }

    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "What will be your next trip?"
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: Fonts.poppinsBold, size: 30)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75)
        ])
    }

    private func configureFromTextField() {
        view.addSubview(fromTextField)

        NSLayoutConstraint.activate([
            fromTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            fromTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fromTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            fromTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func configureToTextField() {
        view.addSubview(toTextField)

        NSLayoutConstraint.activate([
            toTextField.topAnchor.constraint(equalTo: fromTextField.bottomAnchor, constant: 16),
            toTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            toTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureWhenTextField() {
        view.addSubview(whenTextField)

        NSLayoutConstraint.activate([
            whenTextField.topAnchor.constraint(equalTo: toTextField.bottomAnchor, constant: 16),
            whenTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            whenTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            whenTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureSearchButton() {
        view.addSubview(searchButton)

        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: whenTextField.bottomAnchor, constant: 16),
            searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

