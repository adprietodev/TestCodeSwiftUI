//
//  ProductRemoteDataSource.swift
//  TestCode
//
//  Created by Adrian Prieto Villena on 18/10/24.
//

import Foundation

class ProductRemoteDataSource: ProductRemoteDataSourceProtocol {
    // MARK: - Functions
    func getProducts() -> [ProductDTO] {
        ProductDTO.mocks
    }
}
