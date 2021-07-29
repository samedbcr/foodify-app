//
//  Game.swift
//  VideoGamesApp
//
//  Created by Samed Biçer on 28.07.2021.
//

import Foundation

struct Game: Decodable {
    let id: Int
    let name: String
    let released: String
    let backgroundImage: String
    let rating: Double
    let metacritic: Int?
    let description: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case backgroundImage
        case rating
        case metacritic
        case description
    }
}
