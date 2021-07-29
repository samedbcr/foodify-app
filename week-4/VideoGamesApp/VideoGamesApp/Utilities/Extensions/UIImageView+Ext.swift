//
//  UIImageView+Ext.swift
//  VideoGamesApp
//
//  Created by Samed Biçer on 28.07.2021.
//

import UIKit

extension UIImageView {
    func downloadImage(from url: String, placeholder: String) {
        let placeholderImage = UIImage(named: placeholder)
        image = placeholderImage
        guard let url = URL(string: url) else { return }

        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }

            guard let image = UIImage(data: data) else { return }

            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.image = image
            }
        }
        dataTask.resume()
    }
}
