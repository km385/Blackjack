//
//  GameOverView.swift
//  blackjack
//
//  Created by student on 08/01/2025.
//

import SwiftUI
struct GameOverView: View {
    let viewModel: BlackjackViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Time's Up!")
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(.red)
            
            Text("Your session has ended")
                .font(.title2)
            
            Text("Final Balance: $\(viewModel.playerBalance)")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.green)
            
            Button(action: {
                viewModel.resetGame()
                
            }, label: {
                Text("Start New Game")
                    .font(.title2)
                    .padding()
                    .frame(width: 200)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(15)
            })
        }
        .padding(30)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}


#Preview {
    GameOverView(viewModel: BlackjackViewModel())
}
