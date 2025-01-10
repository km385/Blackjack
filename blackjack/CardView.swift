//
//  CardView.swift
//  blackjack
//
//  Created by student on 08/01/2025.
//
import SwiftUI

struct CardView: View {
    let card: BlackjackModel.Card
    let faceUp: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(faceUp ? .white : .blue)
                .frame(width: 60, height: 90)
            
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 2)
                .frame(width: 60, height: 90)
            
            if faceUp {
                VStack {
                    Text(card.value)
                        .font(.headline)
                    Text(card.suit)
                        .font(.title)
                        .foregroundColor(card.suit == "♦" || card.suit == "♥" ? .red : .black)
                }
            } else {
                Text("🂠")
                    .font(.largeTitle)
            }
        }
    }
}

#Preview {
    CardView(card: BlackjackModel.Card(suit: "1", value: "2"), faceUp: true)    
}
