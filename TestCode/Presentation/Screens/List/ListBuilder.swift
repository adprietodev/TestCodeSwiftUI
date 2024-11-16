//
//  ListBuilder.swift
//  TestCode
//
//  Created by Adrian Prieto Villena on 15/11/24.
//

import Foundation

class ListBuilder {
    func build() -> ListView {
        let viewModel = ListViewModel()
        return ListView(viewModel: viewModel)
    }
}
