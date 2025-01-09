//
//  ContentView.swift
//  blackjack
//
//  Created by student on 08/01/2025.
//

import SwiftUI
struct ContentView: View {
    @ObservedObject var viewModel: BlackjackViewModel
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
            
            VStack {
                VStack(spacing: 10) {
                    Text("Blackjack")
                        .font(.system(size: 40, weight: .bold))
                        .padding(.top)
                    
                    ProgressView(value: Double(viewModel.timeRemaining), total: 30)
                        .frame(height: 10)
                        .padding(.horizontal)
                }
                .padding()
                
                if viewModel.isTimeUp {
                    GameOverView(viewModel: viewModel)
                } else if viewModel.currentBet == 0 {
                    BettingView(viewModel: viewModel)
                } else {
                    GameView(viewModel: viewModel)
                }
            }
        }
        
    }
    
}

#Preview {
    ContentView(viewModel: BlackjackViewModel())
        
}

