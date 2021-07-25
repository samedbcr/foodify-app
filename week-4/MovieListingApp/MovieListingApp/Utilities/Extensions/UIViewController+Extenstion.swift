//
//  UIViewController+Extenstion.swift
//  MovieListingApp
//
//  Created by Samed Biçer on 26.07.2021.
//

import UIKit

fileprivate var containerView: UIView!

extension UIViewController {

    func presentLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor = .black
        containerView.alpha = 0

        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.75
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .systemGray3
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
}
