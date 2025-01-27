//
//  PermissionsViewModel.swift
//  TestCode
//
//  Created by Adrian Prieto Villena on 19/1/25.
//

import Foundation

class PermissionsViewModel: ObservableObject {
    struct UIState {
        var camaraImageData = [Data]()
        var galleryImageData = [Data]()
        var location: Coordinate?
        var error: AppError?
    }
    
    private var cameraManager: PermissionsProtocol
    private var galleryManager: PermissionsProtocol
    private var locationManager: LocationManagerProtocol
    
    @Published var uiState = UIState()
    var hasCameraPermission: ((Bool, CustomPermissions) -> Void)?
    var hasGalleryPermission: ((Bool, CustomPermissions) -> Void)?
    var hasLocationPermission: ((Bool, CustomPermissions) -> Void)?
    
    init(cameraManager: PermissionsProtocol,
         galleryManager: PermissionsProtocol,
         locationManager: LocationManagerProtocol) {
        self.cameraManager = cameraManager
        self.galleryManager = galleryManager
        self.locationManager = locationManager
    }
    
    func checkCameraPermission() {
        Task {
            let status = await cameraManager.permissionsStatus()
            let hasPermission = await cameraManager.hasPermissions()
            hasCameraPermission?(hasPermission, status)
        }
    }
    
    func checkGalleryPermission() {
        Task {
            let status = await galleryManager.permissionsStatus()
            let hasPermission = await galleryManager.hasPermissions()
            hasGalleryPermission?(hasPermission, status)
        }
    }
    
    func checkLocationPermission() {
        Task {
            let status = await locationManager.permissionsStatus()
            let hasPermission = await locationManager.hasPermissions()
            hasLocationPermission?(hasPermission, status)
        }
    }
    
    @MainActor
    func getLocation() {
        DispatchQueue.main.async {
            self.uiState.location = self.locationManager.getLocation()
        }
    }
}
