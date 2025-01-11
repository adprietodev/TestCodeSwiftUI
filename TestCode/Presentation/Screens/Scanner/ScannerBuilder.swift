//
//  ScannerBuilder.swift
//  TestCode
//
//  Created by Adrian Prieto Villena on 23/11/24.
//

import Foundation

class ScannerBuilder {
    func build() -> ScannerView {
        let viewModel = ScannerViewModel()
        return ScannerView(viewModel: viewModel)
    }
}
