//
//  CustomSearchBarView.swift
//  TestCode
//
//  Created by Adrian Prieto Villena on 16/11/24.
//

import SwiftUI

struct CustomSearchBarView: View {
    @Binding var searchText: String
    @State private var isSearching = false
    @State private var cancelTextOpacity = 0.0
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("buscar", text: $searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                    .focused($isFocused)
                    .padding(8)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .onChange(of: isFocused) {
                        withAnimation {
                            isSearching = isFocused
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
                        .transition(.move(edge: .trailing))
                        .opacity(cancelTextOpacity)
                        .animation(.easeInOut, value: isSearching)
                        .onAppear {
                            withAnimation {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                    cancelTextOpacity = 1
                                }
                            }
                        }
                        .onDisappear {
                            cancelTextOpacity = 0
                        }
                }
            }

        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .animation(.easeInOut, value: isSearching)
    }
}

#Preview {
    ListBuilder().build()
}
