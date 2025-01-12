//
//  GameOverView.swift
//  blackjack
//
//  Created by student on 12/01/2025.
//

import SwiftUI

struct GameOverView: View {
    @ObservedObject var viewModel: BlackjackViewModel
    @State private var showWinner = false
    
    var body: some View {
        VStack(spacing: 15) {
            Text(viewModel.winner ?? "Draw")
                .font(.title)
                .fontWeight(.bold)
                .opacity(showWinner ? 1 : 0)
                .onAppear {
                    withAnimation(.easeIn(duration: 0.5)) {
                        showWinner = true
                    }
                }
            
            Button(action: viewModel.startNewGame) {
                ActionButton(title: "New Game", color: .green)
                    .frame(width: 200) 
            }
            .scaleEffect(showWinner ? 1 : 0.5)
            .opacity(showWinner ? 1 : 0)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.7)) {
                    showWinner = true
                }
            }
        }
    }
}
