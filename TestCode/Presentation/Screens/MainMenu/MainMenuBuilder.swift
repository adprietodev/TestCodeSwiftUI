//
//  MainMenuBuilder.swift
//  TestCode
//
//  Created by Adrian Prieto Villena on 16/11/24.
//

import Foundation

class MainMenuBuilder {
    func build() -> MainMenuView {
        let viewModel = MainMenuViewModel()
        return MainMenuView(viewModel: viewModel)
    }
}
