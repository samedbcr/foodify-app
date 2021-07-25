//
//  UIImageView+Extension.swift
//  MovieListingApp
//
//  Created by Samed Biçer on 24.07.2021.
//

import UIKit

extension UIImageView {
    func downloadImage(from url: String, with size: Int, placeholder: String) {
        let placeholderImage = UIImage(named: placeholder)
        image = placeholderImage
        let baseURL = "https://image.tmdb.org/t/p/"
        let endPoint = "\(baseURL)w\(size)\(url)"
        guard let url = URL(string: endPoint) else { return }

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
