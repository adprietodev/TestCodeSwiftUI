//
//  PermissionsBuilder.swift
//  TestCode
//
//  Created by Adrian Prieto Villena on 19/1/25.
//

import Foundation

class PermissionsBuilder {
    func build() -> PermissionsView {
        let cameraUseCase = CameraUseCase()
        let galleryUseCase = GalleryUseCase()
        let locationUseCase = LocationUseCase()
        let viewModel = PermissionsViewModel(cameraUseCase: cameraUseCase,
                                             galleryUseCase: galleryUseCase,
                                             locationUseCase: locationUseCase)
        return PermissionsView(viewModel: viewModel)
    }
}
