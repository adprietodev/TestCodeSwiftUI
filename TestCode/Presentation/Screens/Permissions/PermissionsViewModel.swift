//
//  PermissionsViewModel.swift
//  TestCode
//
//  Created by Adrian Prieto Villena on 19/1/25.
//

import Foundation

class PermissionsViewModel: ObservableObject {
    struct UIState {
    }

    private var cameraUseCase: PermissionsProtocol
    private var galleryUseCase: PermissionsProtocol
    private var locationUseCase: LocationUseCaseProtocol
    
    @Published var uiState = UIState()
    var hasPermissionCamera: ((Bool, CustomPermissions) -> Void)?

    init(cameraUseCase: PermissionsProtocol,
         galleryUseCase: PermissionsProtocol,
         locationUseCase: LocationUseCaseProtocol) {
        self.cameraUseCase = cameraUseCase
        self.galleryUseCase = galleryUseCase
        self.locationUseCase = locationUseCase
    }

    func checkPermisionsCamera() {
        Task {
            let status = await cameraUseCase.permissionsStatus()
            let hasPermission = await cameraUseCase.hasPermissions()
            hasPermissionCamera?(hasPermission, status)
        }
    }
}
