//
//  blackjackApp.swift
//  blackjack
//
//  Created by student on 08/01/2025.
//

import SwiftUI

@main
struct blackjackApp: App {
    @StateObject var game = BlackjackViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
