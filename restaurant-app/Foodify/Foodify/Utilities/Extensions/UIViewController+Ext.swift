//
//  UIViewController+Ext.swift
//  Foodify
//
//  Created by Samed Biçer on 11.08.2021.
//

import UIKit

extension UIViewController {
    func presentCustomAlert(alertTitle: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = CustomAlertVC(alertTitle: alertTitle, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
