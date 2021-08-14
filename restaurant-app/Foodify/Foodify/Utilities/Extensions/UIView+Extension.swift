//
//  UIView+Extension.swift
//  Foodify
//
//  Created by Samed Biçer on 14.08.2021.
//

import UIKit

extension UIView {
    func addLeadingBorder(color: UIColor, width: CGFloat) {
        let borderView = UIView(frame: CGRect.zero)
        borderView.backgroundColor = color
        self.addSubview(borderView)
        borderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            borderView.topAnchor.constraint(equalTo: self.topAnchor),
            borderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            borderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            borderView.widthAnchor.constraint(equalToConstant: width)
        ])
    }

    func addTrailingBorder(color: UIColor, width: CGFloat) {
        let borderView = UIView(frame: CGRect.zero)
        borderView.backgroundColor = color
        self.addSubview(borderView)
        borderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            borderView.topAnchor.constraint(equalTo: self.topAnchor),
            borderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            borderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            borderView.widthAnchor.constraint(equalToConstant: width)
        ])
    }
}
