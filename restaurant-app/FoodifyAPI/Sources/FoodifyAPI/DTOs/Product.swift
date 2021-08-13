//
//  Product.swift
//  
//
//  Created by Samed Biçer on 13.08.2021.
//

import Foundation

public struct Product: Decodable {
    public let imagePath: String
    public let name: String
    public let price: Double
    public let ratingCount: Int
}
