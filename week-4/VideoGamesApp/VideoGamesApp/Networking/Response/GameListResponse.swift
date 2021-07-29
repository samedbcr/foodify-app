//
//  GameListResponse.swift
//  VideoGamesApp
//
//  Created by Samed Biçer on 28.07.2021.
//

import Foundation

struct GameListResponse: Decodable {
    let games: [Game]
    
    private enum CodingKeys: String, CodingKey {
        case games = "results"
    }
}
