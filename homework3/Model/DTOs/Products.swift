//
//  Products.swift
//  homework3
//
//  Created by Dariya on 14/1/24.
//

import Foundation

struct ProductItem: Codable {
    let id: Int
    let productTitle: String
    let productImage: String
    let productDescription: String
}

struct Product: Codable {
    let products: [ProductItem]
}
