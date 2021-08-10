//
//  SmallIconButtonView.swift
//  Foodify
//
//  Created by Samed Biçer on 10.08.2021.
//

import UIKit

final class SmallIconButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        imageView?.contentMode = .scaleAspectFit
        imageEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 24),
            heightAnchor.constraint(equalToConstant: 24),
        ])
    }

    func setup(with model: SmallIconButtonUIModel) {
        setImage(UIImage(systemName: model.icon), for: .normal)
        backgroundColor = UIColor(named: model.backgroundColor)
        tintColor = UIColor(named: model.iconColor)
        layer.cornerRadius = CGFloat(model.radius)
    }
}
