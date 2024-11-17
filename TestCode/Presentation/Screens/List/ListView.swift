//
//  ListView.swift
//  TestCode
//
//  Created by Adrian Prieto Villena on 15/11/24.
//

import SwiftUI

struct ListView: View {
    @StateObject var viewModel: ListViewModel
    
    var body: some View {
        NavigationStack {
            CustomSearchBarView(searchText: $viewModel.uiState.searchText)
            List {
                ForEach(viewModel.posts) { post in
                    cardPost(post: post)
                }
            }
            .listStyle(.plain)
            .listRowSpacing(36)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
    }
    
    @ViewBuilder
    private func cardPost(post: Post) -> some View {
        if let firstID = viewModel.posts.first?.id {
            CardPost(post: post)
                .frame(maxHeight: .infinity)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
                .padding(.top, post.id == firstID  ? 12 : 0)
        }
    }
    
}

#Preview {
    ListBuilder().build()
}
