//
//  ErrorMessage.swift
//  
//
//  Created by Samed Biçer on 18.08.2021.
//

import Foundation

public enum ErrorMessage: String, Error {
    case invalidURL = "Invalid request URL!"
    case unableToComplete = "Unable to complete request"
    case invalidResponse = "Invalid response"
    case invalidData = "Invalid data"
}
