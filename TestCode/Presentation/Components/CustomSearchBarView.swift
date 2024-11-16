//
//  CustomSearchBarView.swift
//  TestCode
//
//  Created by Adrian Prieto Villena on 16/11/24.
//

import SwiftUI

struct CustomSearchBarView: View {
    @State private var isSearching = false
    @Binding var searchText: String
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search", text: $searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                    .focused($isFocused)
                    .padding(8)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .onChange(of: isFocused) { newValue in
                        withAnimation {
                            isSearching = newValue
                        }
                    }
                
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 8)
                }
            }
            .padding(.horizontal, 8)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            
            if isSearching {
                Button(action: {
                    isSearching = false
                    searchText = ""
                    isFocused = false
                }) {
                    Text("Cancelar")
                        .foregroundColor(.blue)
                }
                .transition(.move(edge: .trailing))
                .animation(.easeInOut, value: isSearching)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .animation(.easeInOut, value: isSearching)
    }
}
