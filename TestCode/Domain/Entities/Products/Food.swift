//
//  Food.swift
//  TestCode
//
//  Created by Adrian Prieto Villena on 18/10/24.
//

import Foundation

struct Food: ProductProtocol {
    var id: Int
    var name: String
    var description: String
    var price: Double
    var category: String
    var calories: Int
    var ingredients: [String]
    var isVegetarian: Bool
    var isGlutenFree: Bool
    var spicinessLevel: Int
    var imageURL: String
    var availability: Bool
    var preparationTime: Int
    var allergens: [String]
}
