//
//  SecondVC.swift
//  TicketApp
//
//  Created by Samed Biçer on 30.07.2021.
//

import UIKit

class TicketVC: UIViewController {
    private let gradientLayer = CAGradientLayer()
    private let directionSectionStackView = UIStackView()
    private let directionSectionView = UIView()
    private let dateView = ShadowView()
    private let dateStackView = UIStackView()
    private let propsStackView = UIStackView()
    private var dateViewTopConstraint: NSLayoutConstraint?

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
        configureDirectionSectionStackView()
        configureDirectionSectionView()
        configureDateView()
        configureDateStackView()
        configurePropsStackView()
    }

    private func configureDirectionSectionStackView() {
        view.addSubview(directionSectionStackView)
        directionSectionStackView.translatesAutoresizingMaskIntoConstraints = false
        directionSectionStackView.axis = .horizontal
        directionSectionStackView.alignment = .center
        directionSectionStackView.distribution = .equalSpacing

        directionSectionStackView.addArrangedSubview(createDirectionStackView(directionText: "Departure", locationText: "LON", timeText: "14:20 PM", alignment: .leading))
        directionSectionStackView.addArrangedSubview(createDirectionIcon())
        directionSectionStackView.addArrangedSubview(createDirectionStackView(directionText: "Arrive", locationText: "MAN", timeText: "16:30 PM", alignment: .trailing))

        NSLayoutConstraint.activate([
            directionSectionStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            directionSectionStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            directionSectionStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }

    private func createDirectionStackView(directionText: String, locationText: String, timeText: String, alignment: UIStackView.Alignment) -> UIStackView {
        let directionStackView = UIStackView()
        view.addSubview(directionStackView)
        directionStackView.axis = .vertical
        directionStackView.alignment = alignment
        directionStackView.distribution = .fill

        let directionTitleLabel = UILabel()
        directionTitleLabel.text = directionText
        directionTitleLabel.font = UIFont(name: Fonts.poppinsMedium, size: 16)
        directionTitleLabel.textColor = .white

        let locationLabel = UILabel()
        locationLabel.text = locationText
        locationLabel.font = UIFont(name: Fonts.poppinsBold, size: 32)
        locationLabel.textColor = .tertiary

        let timeLabel = UILabel()
        timeLabel.text = timeText
        timeLabel.font = UIFont(name: Fonts.poppinsMedium, size: 15)
        timeLabel.textColor = .white

        directionStackView.addArrangedSubview(directionTitleLabel)
        directionStackView.addArrangedSubview(locationLabel)
        directionStackView.setCustomSpacing(12, after: locationLabel)
        directionStackView.addArrangedSubview(timeLabel)
        return directionStackView
    }

    private func createDirectionIcon() -> UIImageView {
        let imageView = UIImageView()
        let imageViewConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .medium)
        imageView.image = UIImage(systemName: "arrow.forward", withConfiguration: imageViewConfig)
        imageView.tintColor = .appLightGray

        return imageView
    }

    private func configureDirectionSectionView() {
        view.addSubview(directionSectionView)
        directionSectionView.translatesAutoresizingMaskIntoConstraints = false
        directionSectionView.backgroundColor = .backgroundPrimary

        view.bringSubviewToFront(directionSectionStackView)

        NSLayoutConstraint.activate([
            directionSectionView.topAnchor.constraint(equalTo: view.topAnchor),
            directionSectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            directionSectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            directionSectionView.bottomAnchor.constraint(equalTo: directionSectionStackView.bottomAnchor, constant: 60),
        ])
    }

    private func configureDateView() {
        view.addSubview(dateView)
        dateView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            dateView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.80),
            dateView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    private func configureDateStackView() {
        dateView.addSubview(dateStackView)
        dateStackView.translatesAutoresizingMaskIntoConstraints = false

        dateStackView.axis = .horizontal
        dateStackView.alignment = .center
        dateStackView.distribution = .fill
        dateStackView.spacing = 8

        dateStackView.backgroundColor = .white
        dateStackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        dateStackView.isLayoutMarginsRelativeArrangement = true
        dateStackView.layer.cornerRadius = 10
        dateStackView.layer.masksToBounds = true

        let dateLabel = UILabel()
        dateLabel.text = "Friday, 29 Aug 2021"
        dateLabel.font = UIFont(name: Fonts.poppinsMedium, size: 16)

        let dateIcon = UIImageView()
        let dateIconConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .regular)
        dateIcon.image = UIImage(systemName: "calendar", withConfiguration: dateIconConfig)
        dateIcon.tintColor = .systemGray2

        dateStackView.addArrangedSubview(dateLabel)
        dateStackView.addArrangedSubview(dateIcon)

        NSLayoutConstraint.activate([
            dateStackView.topAnchor.constraint(equalTo: dateView.topAnchor),
            dateStackView.leadingAnchor.constraint(equalTo: dateView.leadingAnchor),
            dateStackView.trailingAnchor.constraint(equalTo: dateView.trailingAnchor),
            dateStackView.bottomAnchor.constraint(equalTo: dateView.bottomAnchor),
        ])

        dateView.layoutIfNeeded()
        dateView.topAnchor.constraint(equalTo: directionSectionView.bottomAnchor, constant: -(dateView.frame.height / 2)).isActive = true
    }

    private func configurePropsStackView() {
        view.addSubview(propsStackView)
        propsStackView.translatesAutoresizingMaskIntoConstraints = false

        propsStackView.axis = .vertical
        propsStackView.alignment = .leading
        propsStackView.distribution = .fill
        propsStackView.spacing = 24

        propsStackView.addArrangedSubview(createPropsSubStackView(first: createItemStackView(titleText: "Type", valueText: "One Way", alignment: .leading), second: createItemStackView(titleText: "Discount", valueText: "Student", alignment: .trailing)))
        propsStackView.addArrangedSubview(createPropsSubStackView(first: createItemStackView(titleText: "Duration", valueText: "2h 10m", alignment: .leading), second: createItemStackView(titleText: "Changes", valueText: "None", alignment: .trailing)))

        NSLayoutConstraint.activate([
            propsStackView.topAnchor.constraint(equalTo: dateView.bottomAnchor, constant: 24),
            propsStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.80),
            propsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func createPropsSubStackView(first: UIStackView, second: UIStackView) -> UIStackView {
        let propsSubStackView = UIStackView()
        propsStackView.addSubview(propsSubStackView)
        propsSubStackView.translatesAutoresizingMaskIntoConstraints = false

        propsSubStackView.axis = .horizontal
        propsSubStackView.alignment = .top
        propsSubStackView.distribution = .equalCentering
        propsSubStackView.spacing = 8
        
        propsSubStackView.addArrangedSubview(first)
        propsSubStackView.addArrangedSubview(second)
        
        NSLayoutConstraint.activate([
            propsSubStackView.widthAnchor.constraint(equalTo: propsStackView.widthAnchor)
        ])

        return propsSubStackView
    }


    private func createItemStackView(titleText: String, valueText: String, alignment: UIStackView.Alignment) -> UIStackView {
        let itemStackView = UIStackView()
        itemStackView.axis = .vertical
        itemStackView.alignment = alignment
        itemStackView.distribution = .fill
        itemStackView.spacing = 2

        let titleLabel = UILabel()
        titleLabel.text = titleText
        titleLabel.font = UIFont(name: Fonts.poppinsMedium, size: 16)
        titleLabel.textColor = .black

        let valueLabel = UILabel()
        valueLabel.text = valueText
        valueLabel.font = UIFont(name: Fonts.poppinsBold, size: 22)
        valueLabel.textColor = .black

        itemStackView.addArrangedSubview(titleLabel)
        itemStackView.addArrangedSubview(valueLabel)

        return itemStackView
    }


}
