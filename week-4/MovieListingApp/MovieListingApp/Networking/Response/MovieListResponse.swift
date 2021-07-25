//
//  MovieListResponse.swift
//  MovieListingApp
//
//  Created by Samed Biçer on 21.07.2021.
//

import Foundation

struct MovieListResponse: Decodable {
    let page: Int
    let movies: [Movie]

    private enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
    }
}

