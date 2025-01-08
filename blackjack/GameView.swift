//
//  GameView.swift
//  blackjack
//
//  Created by student on 08/01/2025.
//

import SwiftUI
struct GameView: View {
    @ObservedObject var viewModel: BlackjackViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            // Game stats
            HStack {
                Text("Balance: $\(viewModel.playerBalance)")
                    .font(.headline)
                Spacer()
                Text("Bet: $\(viewModel.currentBet)")
                    .font(.headline)
            }
            .padding(.horizontal)
            
            // Dealer's section
            VStack(alignment: .leading, spacing: 10) {
                Text("Dealer's Hand:")
                    .font(.title2)
                    .fontWeight(.bold)
                
                HStack {
                    if let firstCard = viewModel.dealerHand.first {
                        CardView(card: firstCard, faceUp: true)
                    }
                    ForEach(viewModel.dealerHand.dropFirst()) { card in
                        CardView(card: card, faceUp: viewModel.isGameOver)
                    }
                }
                
                Text("Score: \(viewModel.isGameOver ? String(viewModel.dealerScore) : "?")")
                    .font(.title3)
            }
            .padding()
//            .background(Color.white)
//            .cornerRadius(15)
//            .shadow(radius: 5)
            
            // Player's section
            VStack(alignment: .leading, spacing: 10) {
                Text("Your Hand:")
                    .font(.title2)
                    .fontWeight(.bold)
                
                HStack {
                    ForEach(viewModel.playerHand) { card in
                        CardView(card: card, faceUp: true)
                    }
                }
                
                Text("Score: \(viewModel.playerScore)")
                    .font(.title3)
            }
            .padding()
//            .background(Color.white)
//            .cornerRadius(15)
//            .shadow(radius: 5)
            
            // Game controls
            if viewModel.isGameOver {
                VStack(spacing: 15) {
                    Text(viewModel.winner ?? "Draw")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Button(action: viewModel.startNewGame) {
                        Text("New Game")
                            .font(.title2)
                            .padding()
                            .frame(width: 200)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }
                }
            } else {
                HStack(spacing: 20) {
                    Button(action: viewModel.playerHits) {
                        Text("Hit")
                            .font(.title2)
                            .padding()
                            .frame(width: 100)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }
                    
                    Button(action: viewModel.playerStands) {
                        Text("Stand")
                            .font(.title2)
                            .padding()
                            .frame(width: 100)
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }
                    
                    if viewModel.canDoubleDown {
                        Button(action: viewModel.doubleDown) {
                            Text("2x")
                                .font(.title2)
                                .padding()
                                .frame(width: 100)
                                .background(Color.purple)
                                .foregroundColor(.white)
                                .cornerRadius(15)
                        }
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    GameView(viewModel: BlackjackViewModel())
}
