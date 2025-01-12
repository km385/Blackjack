//
//  BalanceView.swift
//  blackjack
//
//  Created by student on 12/01/2025.
//

import SwiftUI

struct BalanceView: View {
    @ObservedObject var viewModel: BlackjackViewModel
    
    var body: some View {
        HStack {
            Text("Balance: $\(viewModel.playerBalance)")
                .font(.headline)
            Spacer()
            Text("Bet: $\(viewModel.currentBet)")
                .font(.headline)
        }
        .padding(.horizontal)
    }
}
