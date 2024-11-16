//
//  TestCodeApp.swift
//  TestCode
//
//  Created by Adrian Prieto Villena on 18/10/24.
//

import SwiftUI

@main
struct TestCodeApp: App {
    var body: some Scene {
        WindowGroup {
//            ListBuilder().build()
//            TabBarView(selectedTab: .home)
            TestProgressBarBuilder().build()
        }
    }
}
