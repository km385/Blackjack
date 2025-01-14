//
//  BlackjackViewModel.swift
//  blackjack
//
//  Created by student on 08/01/2025.
//

import Foundation
import SwiftUI

class BlackjackViewModel : ObservableObject {
    
    @Published private var game: BlackjackModel
    @Published var betAmount: Int = 10
    @Published var timeRemaining: Int = 30
    @Published var isTimeUp: Bool = false
    
    private var timer: Timer?
    private var hasTimerStarted: Bool = false
    
    init() {
        self.game = BlackjackModel()
    }
        
    private func startTimer() {
        guard !hasTimerStarted else { return }
        
        hasTimerStarted = true
        timeRemaining = 30
        isTimeUp = false
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.timeUp()
            }
        }
    }
        
    private func timeUp() {
        timer?.invalidate()
        timer = nil
        isTimeUp = true

    }

    func placeBet() {
        if game.placeBet(betAmount) {
            if !hasTimerStarted {
                startTimer() // Start timer only on first bet
            }

        }
    }
    

    
    var currentBet: Int {
        game.currentBet
    }
    
    var playerBalance: Int {
        game.playerBalance
    }
    
    var canDoubleDown: Bool {
        game.canDoubleDown && game.playerBalance >= game.currentBet
    }
        
    var playerHand: [Card] {
        game.playerHand
    }
    
    var dealerHand: [Card] {
        game.dealerHand
    }
    
    var playerScore: Int {
        game.playerScore
    }
    
    var dealerScore: Int {
        game.dealerScore
    }
    
    var isGameOver: Bool {
        game.isGameOver
    }
    
    var winner: String? {
        game.winner
    }
    
    
    func dealerPlays() {
        game.dealerPlays()
    }
    
        
    
    func startNewGame() {
        if !isTimeUp {
            game.startNewGame()
            if(game.isTimeUp) {
                isTimeUp = true
                timeRemaining = 0
            }
            if betAmount > game.playerBalance{
                betAmount = playerBalance
            }
        }
    }
        
    func playerHits() {
        if !isTimeUp {
            game.playerHits()

        }
    }
    
    func resetGame() {
        game.resetGame()
        betAmount = 10
        timeRemaining = 30
        isTimeUp = false
        
        timer = nil
        hasTimerStarted = false
    }
    
    func playerStands() {
        if !isTimeUp {
            game.playerStands()
        }
    }
    
    func doubleDown() {
        if !isTimeUp {
            if game.doubleDown() {

            }
        }
    }
    
    deinit {
        timer?.invalidate()
    }
}
