//
//  NetworkManager.swift
//  VideoGamesApp
//
//  Created by Samed Biçer on 28.07.2021.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    let baseURL = "https://api.rawg.io/api"
    let apiKey = "0127aaea7ef4424a8d7f3dd6b070dfc5"

    private init() { }

    func getMovieList(at page: Int, completionHandler: @escaping (Result<[Game], ErrorMessage>) -> Void) {
//      https://api.rawg.io/api/games?key=0127aaea7ef4424a8d7f3dd6b070dfc5&page=3
        let endPoint = "\(baseURL)/games?key=\(apiKey)&page=\(page)&page_size=20"

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
                let gameListReponse = try decoder.decode(GameListResponse.self, from: data)
                let games = gameListReponse.games
                completionHandler(.success(games))
            } catch {
                completionHandler(.failure(.invalidData))
            }
        }
        dataTask.resume()
    }

    func getMovie(id: Int, completionHandler: @escaping (Result<Game, ErrorMessage>) -> Void) {
//        https://api.rawg.io/api/games/416?key=0127aaea7ef4424a8d7f3dd6b070dfc5&page=3
        let endPoint = "\(baseURL)/games/\(id)?key=\(apiKey)"

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
                let game = try decoder.decode(Game.self, from: data)
                completionHandler(.success(game))
            } catch {
                completionHandler(.failure(.invalidData))
            }
        }
        dataTask.resume()
    }
}
