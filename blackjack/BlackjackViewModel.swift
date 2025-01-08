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
    @Published var timeRemaining: Int = 120 // 2 minutes in seconds
    @Published var isTimeUp: Bool = false
    
    private var timer: Timer?
    private var hasTimerStarted: Bool = false
    
    init() {
        self.game = BlackjackModel()
    }
        
    private func startTimer() {
            guard !hasTimerStarted else { return }
            
            hasTimerStarted = true
            timeRemaining = 120 // Set initial time
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
            objectWillChange.send()
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
        
    func placeBet() {
            if game.placeBet(betAmount) {
                if !hasTimerStarted {
                    startTimer() // Start timer only on first bet
                }
                objectWillChange.send()
            }
        }
        
       
        
        // Publiczne właściwości, które udostępniają dane do widoku
        var playerHand: [BlackjackModel.Card] {
            game.playerHand
        }
        
        var dealerHand: [BlackjackModel.Card] {
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
        
        // Funkcje kontrolujące rozgrywkę
        
        
        
        func dealerPlays() {
            game.dealerPlays()
        }
    
        
    
    // When starting a new game, check if time is up
        func startNewGame() {
            if !isTimeUp {
                game.startNewGame()
                objectWillChange.send()
            }
        }
        
        // Disable all game actions if time is up
        func playerHits() {
            if !isTimeUp {
                game.playerHits()
                objectWillChange.send()
            }
        }
        
        func playerStands() {
            if !isTimeUp {
                game.playerStands()
                objectWillChange.send()
            }
        }
        
        func doubleDown() {
            if !isTimeUp {
                if game.doubleDown() {
                    objectWillChange.send()
                }
            }
        }
        
        // Cleanup timer when view model is deallocated
        deinit {
            timer?.invalidate()
        }
}
