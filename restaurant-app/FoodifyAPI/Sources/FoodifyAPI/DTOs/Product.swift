//
//  Product.swift
//
//
//  Created by Samed Biçer on 13.08.2021.
//

import Foundation

public struct Product: Decodable {
//    {
//        "id": 2,
//        "image_path": "https://foodify-app.s3.eu-west-3.amazonaws.com/cereal_and_malt.png",
//        "name": "Cereal Malt",
//        "description": "Malt is germinated cereal grain that has been dried in a process known as \"malting\". The grain is made to germinate by soaking in water.",
//        "price": 18,
//        "rating_count": 3,
//        "ingredients": [
//            {
//                "name": "Carb",
//                "value": 115,
//                "image_path": "https://foodify-app.s3.eu-west-3.amazonaws.com/wheat.png"
//            },
//            {
//                "name": "Fat",
//                "value": 30,
//                "image_path": "https://foodify-app.s3.eu-west-3.amazonaws.com/meat_icon.png"
//            },
//            {
//                "name": "Protein",
//                "value": 15,
//                "image_path": "https://foodify-app.s3.eu-west-3.amazonaws.com/egg.png"
//            }
//        ],
//        "category_id": 5,
//        "is_favorited": false
//    }
    public let id: Int
    public let imagePath: String
    public let name: String
    public let description: String
    public let price: Double
    public let ratingCount: Int
    public let ingredients: [Ingredient]
}

public struct Ingredient: Decodable {
    public let name: String
    public let imagePath: String
    public let value: Double
}
