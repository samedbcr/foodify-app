//
//  Cart.swift
//  
//
//  Created by Samed Biçer on 17.08.2021.
//

import Foundation

public struct Cart: Decodable {
//    {
//        "id": 1,
//        "product_id": 2,
//        "is_deleted": false,
//        "count": 4,
//        "product_name": "Cereal Malt",
//        "image_path": "https://foodify-app.s3.eu-west-3.amazonaws.com/cereal_and_malt.png",
//        "price": 18,
//        "category_name": "Dessert"
//    }
    public let id: Int
    public let product_id: Int
    public let isDeleted: Bool
    public let count: Int
    public let productName: String
    public let imagePath: String
    public let price: Double
    public let categoryName: String
    
}

