//
//  GalleryUseCase.swift
//  TestCode
//
//  Created by Adrian Prieto Villena on 17/1/25.
//

import Photos

class GalleryManager: PermissionsProtocol {
    func hasPermissions() async -> Bool {
        switch getStatusPermission() {
        case .authorized:
            return true
        case .notDetermined:
            let permission = await requestPermission()
            return permission == .authorized
        default:
            return false
        }
    }

    func permissionsStatus() async -> CustomPermissions {
        switch getStatusPermission() {
        case .authorized:
            return .authorized
        case .notDetermined:
            return .notDetermined
        case .limited:
            return .limited
        case .denied:
            return .denied
        case .restricted:
            return .restricted
        default:
            return .denied
        }
    }
}

private extension GalleryManager {
    func requestPermission() async -> PHAuthorizationStatus {
        return await PHPhotoLibrary.requestAuthorization(for: .addOnly)
    }
    
    func getStatusPermission() -> PHAuthorizationStatus {
        return PHPhotoLibrary.authorizationStatus(for: .addOnly)
    }
}
