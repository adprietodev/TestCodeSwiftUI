//
//  CameraView.swift
//  TestCode
//
//  Created by Adrian Prieto Villena on 19/1/25.
//

import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    // MARK: - Properties
    @Environment(\.presentationMode) var presentationMode
    var imageManager: ImageManager = ImageManager()
    @Binding var imagesData: [Data]

    // MARK: - Functions
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        picker.cameraCaptureMode = .photo
        picker.showsCameraControls = true
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: CameraView

        init(_ parent: CameraView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                let resizedImage = parent.imageManager.resizeImage(image: image, maxHeight: 1350)
                parent.imageManager.compressImage(image: resizedImage ?? UIImage(),
                                                  compressType: .jpeg)
                parent.imagesData.append(parent.imageManager.dataImage ?? Data())
            }
            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
