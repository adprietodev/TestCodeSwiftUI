//
//  ScannerView.swift
//  TestCode
//
//  Created by Adrian Prieto Villena on 23/11/24.
//

import SwiftUI

struct ScannerView: View {
    @StateObject var viewModel: ScannerViewModel
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var permissionMessage = ""
    @State private var allowsEditing = true
    
    var body: some View {
        VStack(spacing: 20) {
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
            } else {
                Text("No se ha seleccionado una imagen")
                    .foregroundColor(.gray)
            }
            Button {
                showImagePicker = true
            } label: {
                Text("Ir a cámara")
            }
        }
        .navigationDestination(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $selectedImage, allowsEditing: $allowsEditing, sourceType: .camera )
                .ignoresSafeArea()
                .navigationBarBackButtonHidden()
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

