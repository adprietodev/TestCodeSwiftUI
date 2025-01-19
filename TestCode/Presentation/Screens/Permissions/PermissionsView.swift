//
//  PermissionsView.swift
//  TestCode
//
//  Created by Adrian Prieto Villena on 19/1/25.
//

import SwiftUI

struct PermissionsView: View {
    @StateObject var viewModel: PermissionsViewModel
    var body: some View {
        VStack {
            Button("Request Permissions") {
                viewModel.checkPermisionsCamera()
            }
        }
        .onAppear {
            viewModel.hasPermissionCamera = { hasPermission, status in
                print("\(hasPermission) - \(status)")
            }
        }
    }
}

#Preview {
    PermissionsBuilder().build()
}
