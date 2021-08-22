//
//  Cart.swift
//
//
//  Created by Samed Biçer on 17.08.2021.
//

import Foundation

public struct Cart: Decodable {
    public let id: Int
    public let productId: Int
    public let isDeleted: Bool
    public let count: Int
    public let productName: String
    public let imagePath: String
    public let price: Double
    public let categoryName: String
}
