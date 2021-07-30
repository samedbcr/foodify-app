//
//  CustomTextField.swift
//  TicketApp
//
//  Created by Samed Biçer on 30.07.2021.
//

import UIKit

class CustomTextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 24)
    var placeholderText = ""
    var rightIcon: UIImage?

    init(placeholder: String, rightIcon: UIImage?) {
        super.init(frame: .zero)
        self.placeholderText = placeholder
        self.rightIcon = rightIcon
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false

        layer.cornerRadius = 6
        backgroundColor = UIColor(red: 0.92, green: 0.92, blue: 0.94, alpha: 1.00)
        font = UIFont(name: Fonts.poppinsRegular, size: 14)
        attributedPlaceholder = NSAttributedString(string: self.placeholderText,
                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])

        if let rightIcon = rightIcon {
            rightViewMode = .always
            let rightImageView = UIImageView(image: rightIcon)
            rightImageView.tintColor = .systemGray2
            rightView = rightImageView
        }

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
