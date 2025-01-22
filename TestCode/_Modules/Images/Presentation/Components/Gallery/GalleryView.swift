//
//  GalleryView.swift
//  TestCode
//
//  Created by Adrian Prieto Villena on 19/1/25.
//

import SwiftUI
import PhotosUI

struct GalleryView: UIViewControllerRepresentable {
    // MARK: - Properties
    var imageManager: ImageManager = ImageManager()
    /// With this variable you can control de selection count of the gallery
    var isMultipleSelection: Bool
    @Binding var imagesData: [Data]

    // MARK: - Functions
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.selectionLimit = isMultipleSelection ? 0 : 1
        config.filter = .images
        config.mode = .default

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        private var parent: GalleryView

        init(_ parent: GalleryView) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController,
                    didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            results.forEach { result in
                let provider = result.itemProvider

                if provider.hasItemConformingToTypeIdentifier(UTType.image.identifier) {
                    provider.loadDataRepresentation(forTypeIdentifier: UTType.image.identifier) { [weak self] data, error in
                        guard let self = self else { return }
                        guard let data = data, error == nil else {
                            print("Error data: \(error?.localizedDescription ?? "Unknown error")")
                            return
                        }

                        guard !data.isEmpty else {
                            print("Data is empty.")
                            return
                        }

                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                // Resize and compress image
                                let resizedImage = self.parent.imageManager.resizeImage(image: image, maxWidth: 1350)
                                self.parent.imageManager.compressImage(image: resizedImage ?? UIImage(), compressType: .jpeg)
                                self.parent.imagesData.append(self.parent.imageManager.dataImage ?? Data())
                            }
                        } else {
                            print("Failed to convert data to UIImage")
                        }
                    }
                }
            }
        }
    }
}
