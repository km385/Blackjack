//
//  GameControlsView.swift
//  blackjack
//
//  Created by student on 12/01/2025.
//

import SwiftUI

struct GameControlsView: View {
    @ObservedObject var viewModel: BlackjackViewModel

    var body: some View {
        HStack(spacing: 20) {
            Button(action: viewModel.playerHits) {
                ActionButton(title: "Hit", color: .blue)
            }

            Button(action: viewModel.playerStands) {
                ActionButton(title: "Stand", color: .orange)
            }

            Button(action: viewModel.doubleDown) {
                ActionButton(title: "2x", color: viewModel.canDoubleDown ? .purple : .gray)
            }
            .disabled(!viewModel.canDoubleDown)
        }
    }
}
