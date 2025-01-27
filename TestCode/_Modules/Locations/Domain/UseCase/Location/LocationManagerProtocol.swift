//
//  LocationUseCaseProtocol.swift
//  TestCode
//
//  Created by Adrian Prieto Villena on 17/1/25.
//

import Foundation

protocol LocationManagerProtocol: PermissionsProtocol {
    func getLocation() -> Coordinate?
}
