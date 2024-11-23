//
//  ProductDTOMock.swift
//  TestCode
//
//  Created by Adrian Prieto Villena on 18/10/24.
//

import Foundation

extension ProductDTO {
    static let pizzaMargherita = ProductDTO(id: 1,
                                            name: "Pizza Margherita",
                                            description: "Delicious traditional pizza with fresh mozzarella, tomatoes, and basil.",
                                            price: 12.99)
    
    static let sushiNigiri = ProductDTO(id: 2,
                                        name: "Sushi Nigiri",
                                        description: "A set of fresh nigiri sushi with salmon, tuna, and shrimp.",
                                        price: 18.50)
    
    static let burgerDelux = ProductDTO(id: 3,
                                        name: "Burger Deluxe",
                                        description: "Juicy beef burger with cheddar cheese, bacon, lettuce, and a side of fries.",
                                        price: 14.75)
    
    static let mocks = [pizzaMargherita, sushiNigiri, burgerDelux]
}
