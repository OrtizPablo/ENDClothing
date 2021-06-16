//
//  Product.swift
//  ENDClothing
//
//  Created by Pablo Ortiz on 12/06/2021.
//

import UIKit

struct Product: Decodable {
    let name: String
    let price: String
    let imagePath: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case price
        case imagePath = "image"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        price = try container.decode(String.self, forKey: .price)
        imagePath = try container.decode(String.self, forKey: .imagePath)
    }
}
