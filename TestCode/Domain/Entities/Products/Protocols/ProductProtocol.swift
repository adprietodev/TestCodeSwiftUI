//
//  ProductProtocol.swift
//  TestCode
//
//  Created by Adrian Prieto Villena on 18/10/24.
//

import Foundation

protocol ProductProtocol {
    var id: Int { get }
    var name: String { get }
    var description: String { get }
    var price: Double { get }
}
