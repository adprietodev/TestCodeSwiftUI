//
//  ListViewModel.swift
//  TestCode
//
//  Created by Adrian Prieto Villena on 15/11/24.
//

import Foundation
import CoreLocation

class ListViewModel: ObservableObject {
    struct UIState {
        var searchText = ""
    }

    @Published var uiState = UIState()
    @Published var posts = Post.mockPosts


}
