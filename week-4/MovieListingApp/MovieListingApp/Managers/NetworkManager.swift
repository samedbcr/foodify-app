//
//  NetworkManager.swift
//  MovieListingApp
//
//  Created by Samed Biçer on 19.07.2021.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    let baseURL = "https://api.themoviedb.org/3/movie/"
    let apiKey = "fd2b04342048fa2d5f728561866ad52a"
    let language = "en-US"

    private init() { }

    func getMovieList(at page: Int, completionHandler: @escaping (Result<[Movie], ErrorMessage>) -> Void) {
//        https://api.themoviedb.org/3/movie/popular?language=en-US&api_key=fd2b04342048fa2d5f728561866ad52a&page=1
        let endPoint = "\(baseURL)popular?language=\(language)&api_key=\(apiKey)&page=\(page)"

        guard let url = URL(string: endPoint) else {
            completionHandler(.failure(.invalidURL))
            return
        }

        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completionHandler(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completionHandler(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movieListReponse = try decoder.decode(MovieListResponse.self, from: data)
                let movies = movieListReponse.movies
                completionHandler(.success(movies))
            } catch {
                completionHandler(.failure(.invalidData))
            }
        }
        dataTask.resume()
    }
}
