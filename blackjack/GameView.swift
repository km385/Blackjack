import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: BlackjackViewModel
    
    // Animation state
    @State private var cardOffset: CGFloat = 25
    @State private var cardScale: CGFloat = 0.8
    @State private var showWinner = false
    
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Balance: $\(viewModel.playerBalance)")
                    .font(.headline)
                Spacer()
                Text("Bet: $\(viewModel.currentBet)")
                    .font(.headline)
            }
            .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Dealer's Hand:")
                    .font(.title2)
                    .fontWeight(.bold)
                
                HStack {
                    if let firstCard = viewModel.dealerHand.first {
                        CardView(card: firstCard, faceUp: true)
                            .scaleEffect(cardScale)
                            .offset(y: cardOffset)
                            .onAppear {
                                withAnimation(.easeIn(duration: 0.5)) {
                                    cardOffset = 0
                                    cardScale = 1
                                }
                            }
                    }
                    ForEach(viewModel.dealerHand.dropFirst()) { card in
                        CardView(card: card, faceUp: viewModel.isGameOver)
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
                
                Text("Score: \(viewModel.isGameOver ? String(viewModel.dealerScore) : "?")")
                    .font(.title3)
            }
            .padding()

            VStack(alignment: .leading, spacing: 10) {
                Text("Your Hand:")
                    .font(.title2)
                    .fontWeight(.bold)
                
                HStack {
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
                
                Text("Score: \(viewModel.playerScore)")
                    .font(.title3)
            }
            .padding()
            
            if viewModel.isGameOver {
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
                        Text("New Game")
                            .font(.title2)
                            .padding()
                            .frame(width: 200)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }
                    .scaleEffect(showWinner ? 1 : 0.5)
                    .opacity(showWinner ? 1 : 0)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 0.7).delay(0.5)) {
                            showWinner = true
                        }
                    }
                }
            } else {
                HStack(spacing: 20) {
                    Button(action: {
                        viewModel.playerHits()
                    }) {
                        Text("Hit")
                            .font(.title2)
                            .padding()
                            .frame(width: 100)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }
                    
                    Button(action: {
                        viewModel.playerStands()
                    }) {
                        Text("Stand")
                            .font(.title2)
                            .padding()
                            .frame(width: 100)
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }
                    
                    
                    Button(action: {
                        viewModel.doubleDown()
                    }) {
                        Text("2x")
                            .font(.title2)
                            .padding()
                            .frame(width: 100)
                            .background(viewModel.canDoubleDown ? Color.purple : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }
                    .disabled(!viewModel.canDoubleDown)
                        
                    
                }
            }
        }
        .padding()
    }
}

#Preview {
    GameView(viewModel: BlackjackViewModel())
    
}
