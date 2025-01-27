//
//  PermissionsBuilder.swift
//  TestCode
//
//  Created by Adrian Prieto Villena on 19/1/25.
//

import Foundation

class PermissionsBuilder {
    func build() -> PermissionsView {
        let cameraManager = CamerManager()
        let galleryManager = GalleryManager()
        let locationManager = LocationManager()
        let viewModel = PermissionsViewModel(cameraManager: cameraManager,
                                             galleryManager: galleryManager,
                                             locationManager: locationManager)
        return PermissionsView(viewModel: viewModel)
    }
}
