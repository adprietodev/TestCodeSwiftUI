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
    }
    
    private var cameraUseCase: PermissionsProtocol
    private var galleryUseCase: PermissionsProtocol
    private var locationUseCase: LocationUseCaseProtocol
    
    @Published var uiState = UIState()
    var hasCameraPermission: ((Bool, CustomPermissions) -> Void)?
    var hasGalleryPermission: ((Bool, CustomPermissions) -> Void)?
    var hasLocationPermission: ((Bool, CustomPermissions) -> Void)?
    
    init(cameraUseCase: PermissionsProtocol,
         galleryUseCase: PermissionsProtocol,
         locationUseCase: LocationUseCaseProtocol) {
        self.cameraUseCase = cameraUseCase
        self.galleryUseCase = galleryUseCase
        self.locationUseCase = locationUseCase
    }
    
    func checkCameraPermission() {
        Task {
            let status = await cameraUseCase.permissionsStatus()
            let hasPermission = await cameraUseCase.hasPermissions()
            hasCameraPermission?(hasPermission, status)
        }
    }
    
    func checkGalleryPermission() {
        Task {
            let status = await galleryUseCase.permissionsStatus()
            let hasPermission = await galleryUseCase.hasPermissions()
            hasGalleryPermission?(hasPermission, status)
        }
    }
    
    func checkLocationPermission() {
        Task {
            let status = await locationUseCase.permissionsStatus()
            let hasPermission = await locationUseCase.hasPermissions()
            hasLocationPermission?(hasPermission, status)
        }
    }
    
    @MainActor
    func getLocation() {
        DispatchQueue.main.async {
            self.uiState.location = self.locationUseCase.getLocation()
        }
    }
}
