//
//  BasicTableRowView.swift
//  Foodify
//
//  Created by Samed Biçer on 11.08.2021.
//

import UIKit

final class BasicTableRowView: UIView {
    private let leadingLabel = UILabel()
    private let trailiingLabel = UILabel()
    private let hStackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        configureStackView()
        configureLeadingLabel()
        configureTrailingLabel()
    }

    private func configureStackView() {
        addSubview(hStackView)
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.axis = .horizontal
        hStackView.distribution = .fill
        hStackView.alignment = .center
        hStackView.spacing = 8

        NSLayoutConstraint.activate([
            hStackView.topAnchor.constraint(equalTo: topAnchor),
            hStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            hStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            hStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    private func configureLeadingLabel() {
        leadingLabel.font = UIFont(name: Fonts.poppinsMedium, size: 14)
        leadingLabel.textColor = .appDarkGray

        hStackView.addArrangedSubview(leadingLabel)
    }

    private func configureTrailingLabel() {
        trailiingLabel.font = UIFont(name: Fonts.poppinsSemiBold, size: 14)
        trailiingLabel.textColor = .primary

        hStackView.addArrangedSubview(trailiingLabel)
    }
    
    func changeTrailingLabel(with value: String) {
        trailiingLabel.text = value
    }

    func setup(with model: BasicTableRowViewUIModel) {
        leadingLabel.text = model.leadingText
        trailiingLabel.text = model.trailingText
        
        if model.isBigText {
            leadingLabel.font = UIFont(name: Fonts.poppinsMedium, size: 19)
            leadingLabel.textColor = .appDark
            
            trailiingLabel.font = UIFont(name: Fonts.poppinsSemiBold, size: 19)
        }
    }
}
