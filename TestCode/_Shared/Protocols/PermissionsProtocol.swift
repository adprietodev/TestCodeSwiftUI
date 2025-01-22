//
//  PermissionsProtocol.swift
//  TestCode
//
//  Created by Adrian Prieto Villena on 17/1/25.
//

import CoreLocation

enum CustomPermissions{
    case authorized
    case denied
    case notDetermined
    case limited
    case restricted
}

enum AlertType {
    case location
    case camera
    case gallery
    case error
}

protocol PermissionsProtocol {
    func hasPermissions() async -> Bool
    func permissionsStatus() async -> CustomPermissions
}
