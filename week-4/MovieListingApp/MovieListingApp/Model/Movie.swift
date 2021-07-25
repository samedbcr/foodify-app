//
//  Movie.swift
//  MovieListingApp
//
//  Created by Samed Biçer on 19.07.2021.
//

import Foundation

struct Movie: Decodable {
    let backdropPath: String?
    let id: Int
    let overview: String
    let posterPath: String
    let releaseDate: String?
    let title: String
    let voteAverage: Double
    let voteCount: Int
    var isFavorited: Bool = false

    private enum CodingKeys: String, CodingKey {
        case backdropPath
        case id
        case overview
        case posterPath
        case releaseDate
        case title
        case voteAverage
        case voteCount
    }
}
