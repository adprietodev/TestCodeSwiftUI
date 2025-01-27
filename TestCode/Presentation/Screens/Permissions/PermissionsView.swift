//
//  PermissionsView.swift
//  TestCode
//
//  Created by Adrian Prieto Villena on 19/1/25.
//

import SwiftUI

struct PermissionsView: View {
    @StateObject var viewModel: PermissionsViewModel
    @State var showCamera = false
    @State var showGallery = false
    @State var showAlert = false
    @State var typeAlert: AlertType = .camera
    
    var body: some View {
        VStack {
            HStack {
                if let location = viewModel.uiState.location {
                    Text("Latitud: \(location.lat)")
                    Text("Longitud: \(location.lng)")
                }
            }
            VStack(spacing: 16) {
                Button {
                    viewModel.checkCameraPermission()
                } label: {
                    Text("CAMERA")
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                }
                .padding(16)
                .background(.black)
                .cornerRadius(8)
                
                Button {
                    viewModel.checkGalleryPermission()
                } label: {
                    Text("GALLERY")
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                }
                .padding(16)
                .background(.black)
                .cornerRadius(8)
                
                Button {
                    viewModel.checkLocationPermission()
                } label: {
                    Text("LOCATION")
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                }
                .padding(16)
                .background(.black)
                .cornerRadius(8)
            }
            .padding(16)
            
            ScrollView {
                Text("Camera images:")
                if !viewModel.uiState.camaraImageData.isEmpty {
                    HStack {
                        ForEach(viewModel.uiState.camaraImageData, id: \.self) { imageData in
                            getImage(imageData)
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                    }
                }
                Text("Gallery images:")
                if !viewModel.uiState.galleryImageData.isEmpty {
                    HStack {
                        ForEach(viewModel.uiState.galleryImageData, id: \.self) { imageData in
                            getImage(imageData)
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                    }
                }
            }
        }
        .alert(isPresented: $showAlert) {
            switch typeAlert {
            case .camera:
                return goToSettingsPopUp(title: Text("cameraPermissionTitle"),
                                         message: Text("cameraPermissionDescription"),
                                         primaryButton: Text("goToSettings"))
            case .gallery:
                return goToSettingsPopUp(title: Text("galleryPermissionTitle"),
                                         message: Text("galleryPermissionDescription"),
                                         primaryButton: Text("goToSettings"))
            case .location:
                return goToSettingsPopUp(title: Text("locationPermissionTitle"),
                                         message: Text("locationPermissionDescription"),
                                         primaryButton: Text("goToSettings"))
            case .error:
                return goToSettingsPopUp(title: Text("generalError"),
                                         message: Text("generalError"))
            }
        }
        .fullScreenCover(isPresented: $showCamera) {
            CameraView(imagesData: $viewModel.uiState.camaraImageData)
                .ignoresSafeArea()
                .navigationBarBackButtonHidden()
                .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $showGallery) {
            GalleryView(isMultipleSelection: false,
                        imagesData: $viewModel.uiState.galleryImageData,
                        error: $viewModel.uiState.error)
        }
        .onAppear {
            viewModel.hasCameraPermission = { hasPermission, status in
                print("\(hasPermission) - \(status)")
                if status != .notDetermined, status != .authorized {
                    typeAlert = .camera
                    showAlert = true
                }
                showCamera = hasPermission
            }
            viewModel.hasGalleryPermission = { hasPermission, status in
                print("\(hasPermission) - \(status)")
                if status != .notDetermined, status != .authorized {
                    typeAlert = .gallery
                    showAlert = true
                }
                showGallery = hasPermission
            }
            viewModel.hasLocationPermission = { hasPermission, status in
                print("\(hasPermission) - \(status)")
                if status != .notDetermined, status != .authorized {
                    typeAlert = .location
                    showAlert = true
                }
                if hasPermission {
                    viewModel.getLocation()
                    if let location = viewModel.uiState.location {
                        print(location)
                    }
                }
            }
        }
    }
}

private extension PermissionsView {
    func goToSettingsPopUp(title: Text,
                           message: Text,
                           primaryButton: Text = Text("accept"),
                           secondaryButton: Text = Text("cancel")) -> Alert {
        Alert(title: title,
              message: message,
              primaryButton: .default(primaryButton) {
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings)
            }
        },
              secondaryButton: .cancel(secondaryButton) {
        })
    }
    
    func getImage(_ imageData: Data?) -> Image {
        guard let data = imageData,
              let uiImage = UIImage(data: data) else {
            return Image(systemName: "photo.badge.exclamationmark")
        }
        return Image(uiImage: uiImage)
    }
}

#Preview {
    PermissionsBuilder().build()
}
