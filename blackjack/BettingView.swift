//
//  BettingView.swift
//  blackjack
//
//  Created by student on 08/01/2025.
//

import SwiftUI

struct BettingView: View {
    @ObservedObject var viewModel: BlackjackViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Place your bet")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Balance: $\(viewModel.playerBalance)")
                .font(.title2)
                .foregroundColor(.green)
            
            HStack(spacing: 30) {
                Button("-10") {
                    viewModel.betAmount = max(10, viewModel.betAmount - 10)
                }
                .disabled(viewModel.betAmount <= 10)
                .font(.title2)
                .padding()
                .background(viewModel.betAmount <= 10 ? Color.gray : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Text("$\(viewModel.betAmount)")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(width: 100)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 2)
                    )
                
                Button("+10") {
                    viewModel.betAmount = min(500, viewModel.betAmount + 10)
                }
                .disabled(viewModel.betAmount >= 500)
                .font(.title2)
                .padding()
                .background(viewModel.betAmount >= 500 ? Color.gray : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            
            Button("Place Bet") {
                viewModel.placeBet()
            }
            .disabled(viewModel.betAmount > viewModel.playerBalance)
            .font(.title)
            .padding(.horizontal, 40)
            .padding(.vertical, 15)
            .background(viewModel.betAmount > viewModel.playerBalance ? Color.gray : Color.green)
            .foregroundColor(.white)
            .cornerRadius(15)
            .shadow(radius: 5)
        }
        .padding(30)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}

#Preview {
    BettingView(viewModel: BlackjackViewModel())
}
