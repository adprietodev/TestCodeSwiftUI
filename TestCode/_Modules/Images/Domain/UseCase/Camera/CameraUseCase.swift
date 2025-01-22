//
//  CameraUseCase.swift
//  TestCode
//
//  Created by Adrian Prieto Villena on 17/1/25.
//

import AVFoundation

class CameraUseCase: PermissionsProtocol {
    func hasPermissions() async -> Bool {
        switch await permissionsStatus() {
        case .authorized:
            return true
        case .notDetermined:
            return await requestPermission()
        default:
            return false
        }
    }
    
    func permissionsStatus() async -> CustomPermissions {
        let permission = getStatusPermission()
        switch permission {
        case .authorized:
            return .authorized
        case .notDetermined:
            return .notDetermined
        case .denied:
            return .denied
        case .restricted:
            return .restricted
        @unknown default:
            return .denied
        }
    }
}

private extension CameraUseCase {
    func requestPermission() async -> Bool {
        return await AVCaptureDevice.requestAccess(for: .video)
    }

    func getStatusPermission() -> AVAuthorizationStatus {
        return AVCaptureDevice.authorizationStatus(for: .video)
    }
}
