//
//  ProductRepository.swift
//  TestCode
//
//  Created by Adrian Prieto Villena on 18/10/24.
//

import Foundation

enum TypeProduct {
    case base
    case food
}

class ProductRepository {
    // MARK: - Properties
    private let remoteDatasource: ProductRemoteDataSourceProtocol

    // MARK: - Init
    init(remoteDatasource: ProductRemoteDataSourceProtocol) {
        self.remoteDatasource = remoteDatasource
    }

    // MARK: - Functions
    func getProducts(type: TypeProduct) -> [ProductProtocol]{
        let responseDTO = remoteDatasource.getProducts()
        return responseDTO.map { $0.toDomain(type: type)}
    }
}

// MARK: - Mappers
fileprivate extension ProductDTO {
    func toDomain(type: TypeProduct) -> ProductProtocol {
        switch type {
        case .base:
            return Product(id: self.id,
                           name: self.name,
                           description: self.description,
                           price: self.price)
        case .food:
            return Food(id: self.id,
                        name: self.name,
                        description: self.description,
                        price: self.price,
                        category: "",
                        calories: 0,
                        ingredients: [],
                        isVegetarian: false,
                        isGlutenFree: false,
                        spicinessLevel: 0,
                        imageURL: "",
                        availability: false,
                        preparationTime: 0,
                        allergens: [])
        }
    }
}
