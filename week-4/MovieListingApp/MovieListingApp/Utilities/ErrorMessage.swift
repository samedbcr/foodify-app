//
//  ErrorMessage.swift
//  MovieListingApp
//
//  Created by Samed Biçer on 21.07.2021.
//

import Foundation

enum ErrorMessage: String, Error {
    case invalidURL = "Invalid request URL!"
    case unableToComplete = "Unable to complete request"
    case invalidResponse = "Invalid response"
    case invalidData = "Invalid data"
}
