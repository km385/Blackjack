//
//  HandView.swift
//  blackjack
//
//  Created by student on 12/01/2025.
//

import SwiftUI

struct HandView: View {
    let title: String
    @ObservedObject var viewModel: BlackjackViewModel
    let isDealer: Bool
    
    @State private var cardOffset: CGFloat = 25
    @State private var cardScale: CGFloat = 0.8
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    if isDealer {
                        ForEach(Array(viewModel.dealerHand.enumerated()), id: \.element.id) { index, card in
                            CardView(
                                card: card,
                                faceUp: index == 0 || viewModel.isGameOver
                            )
                            .scaleEffect(cardScale)
                            .offset(y: cardOffset)
                            .onAppear {
                                withAnimation(.easeIn(duration: 0.5)) {
                                    cardOffset = 0
                                    cardScale = 1
                                }
                            }
                        }
                    } else {
                        ForEach(viewModel.playerHand) { card in
                            CardView(card: card, faceUp: true)
                                .scaleEffect(cardScale)
                                .offset(y: cardOffset)
                                .onAppear {
                                    withAnimation(.easeIn(duration: 0.5)) {
                                        cardOffset = 0
                                        cardScale = 1
                                    }
                                }
                        }
                    }
                }
                .padding(2)
            }
            
            
            Text("Score: \(isDealer ? (viewModel.isGameOver ? String(viewModel.dealerScore) : "?") : String(viewModel.playerScore))")
                .font(.title3)
        }
        .padding()
    }
}
