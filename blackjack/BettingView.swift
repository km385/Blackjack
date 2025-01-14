//
//  BettingView.swift
//  blackjack
//
//  Created by student on 08/01/2025.
//

import SwiftUI

struct BettingView: View {
    @ObservedObject var viewModel: BlackjackViewModel
    @State private var showAlert = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Place your bet")
                .font(.title)
                .fontWeight(.bold)
            HStack {
                Text("Balance: $\(viewModel.playerBalance)")
                    .font(.title2)
                    .foregroundColor(.green)
                Button(action: {
                        showAlert = true
                    }) {
                        Image(systemName: "info.circle.fill")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Information"),
                            message: Text("You can increase your bet by a $100 when you long press the adjust bet button."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
            }
            
            
            HStack(spacing: 30) {
                Text("-10")
                  .font(.title2)
                  .padding()
                  .background(viewModel.betAmount <= 10 ? Color.gray : Color.blue)
                  .foregroundColor(.white)
                  .cornerRadius(10)
                  .highPriorityGesture(
                      TapGesture()
                          .onEnded { _ in
                              viewModel.betAmount = max(10, viewModel.betAmount - 10)
                          }
                  )
                  .gesture(
                      LongPressGesture(minimumDuration: 0.5)
                          .onEnded { _ in
                              viewModel.betAmount = max(10, viewModel.betAmount - 100)
                          }
                  )
                  .disabled(viewModel.betAmount <= 10)
                                
                
                
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
                
                Text("+10")
                  .font(.title2)
                  .padding()
                  .background(viewModel.betAmount >= 500 || viewModel.betAmount >= viewModel.playerBalance ? Color.gray : Color.blue)
                  .foregroundColor(.white)
                  .cornerRadius(10)
                  .highPriorityGesture(
                      TapGesture()
                          .onEnded { _ in
                              if viewModel.playerBalance > 500 {
                                  viewModel.betAmount = min(500, viewModel.betAmount + 10)
                              } else {
                                  viewModel.betAmount = min(viewModel.playerBalance, viewModel.betAmount + 10)
                              }
                          }
                  )
                  .gesture(
                      LongPressGesture(minimumDuration: 0.5)
                          .onEnded { _ in
                              if viewModel.playerBalance > 500 {
                                  viewModel.betAmount = min(500, viewModel.betAmount + 50)
                              } else {
                                  viewModel.betAmount = min(viewModel.playerBalance, viewModel.betAmount + 100)
                              }
                          }
                  )
                  .disabled(viewModel.betAmount >= 500 || viewModel.betAmount >= viewModel.playerBalance)
                
                

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
