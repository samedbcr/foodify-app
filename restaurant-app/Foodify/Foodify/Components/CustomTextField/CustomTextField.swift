//
//  CustomTextField.swift
//  Foodify
//
//  Created by Samed Biçer on 11.08.2021.
//

import UIKit

final class CustomTextField: UITextField {
    private enum Constants {
        static let leftPadding: CGFloat = 12
        static let rightPadding: CGFloat = 40
    }

    let padding = UIEdgeInsets(top: 0, left: Constants.leftPadding, bottom: 0, right: Constants.rightPadding)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 6
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.appDarkGray.cgColor
        backgroundColor = .appMediumGray
        font = UIFont(name: Fonts.poppinsRegular, size: 14)
        textColor = .appDark
        tintColor = .appDark
        autocorrectionType = .no
        returnKeyType = .done
        attributedPlaceholder = NSAttributedString(string: "",
                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.appDarkGray])

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    func setup(with model: CustomTextFieldUIModel) {
        keyboardType = model.keyboardType

        if let icon = model.iconName {
            rightViewMode = .always
            let iconImage = UIImage(systemName: icon)
            let rightImageView = UIImageView(image: iconImage)
            rightImageView.tintColor = .appDarkGray
            rightView = rightImageView

        }
        attributedPlaceholder = NSAttributedString(string: model.placeholder,
                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x += -12
        return rect
    }
}
