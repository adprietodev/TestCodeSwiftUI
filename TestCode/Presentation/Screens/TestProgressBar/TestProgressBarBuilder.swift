//
//  TestProgressBarBuilder.swift
//  TestCode
//
//  Created by Adrian Prieto Villena on 10/11/24.
//

import Foundation

class TestProgressBarBuilder {
    func build() -> TestProgressBarView {
        var viewModel = TestProgressBarViewModel()
        var view = TestProgressBarView(viewModel: viewModel)
        return view
    }
}
