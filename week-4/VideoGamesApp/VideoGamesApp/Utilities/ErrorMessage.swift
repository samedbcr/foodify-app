//
//  ErrorMessage.swift
//  VideoGamesApp
//
//  Created by Samed Biçer on 28.07.2021.
//

import Foundation

enum ErrorMessage: String, Error {
    case invalidURL = "Invalid request URL!"
    case unableToComplete = "Unable to complete request"
    case invalidResponse = "Invalid response"
    case invalidData = "Invalid data"
}
