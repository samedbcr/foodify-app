//
//  Category.swift
//
//
//  Created by Samed Biçer on 12.08.2021.
//

import Foundation

public struct Category: Decodable {
//    {
//        "id": 1,
//        "name": "Meat",
//        "image_path": "https://foodify-app.s3.eu-west-3.amazonaws.com/meat_icon_2.png"
//    }
    public let id: Int
    public let name: String
    public let imagePath: String
}
