//
//  MainMenuView.swift
//  TestCode
//
//  Created by Adrian Prieto Villena on 16/11/24.
//

import SwiftUI

struct MainMenuView: View {
    @StateObject var viewModel: MainMenuViewModel
    @State var searchText = ""

    var body: some View {
        NavigationStack {
            List {
                Section("Test CustomComponents") {
                    NavigationLink("SearchBar") {
                        CustomSearchBarView(searchText: $searchText)
                    }
                }
                Section("Test Progress Bar") {
                    NavigationLink("Progres Bar With Views") {
                        TestProgressBarBuilder().build()
                    }
                }
                Section("Test List") {
                    NavigationLink("List With Cards") {
                        ListBuilder().build()
                    }
                    NavigationLink("Card") {
                        CardPost(post: Post.mockPosts[0])
                    }
                }
            }

        }
    }
}

#Preview {
    MainMenuBuilder().build()
}
