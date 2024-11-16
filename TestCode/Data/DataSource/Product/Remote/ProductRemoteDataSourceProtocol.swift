//
//  ProductRemoteDataSourceProtocol.swift
//  TestCode
//
//  Created by Adrian Prieto Villena on 18/10/24.
//

import Foundation

protocol ProductRemoteDataSourceProtocol {
    func getProducts() -> [ProductDTO]
}
