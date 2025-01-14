//
//  BlackjackModel.swift
//  blackjack
//
//  Created by student on 08/01/2025.
//

import Foundation

struct BlackjackModel {
    private(set) var deck: [Card]
    private(set) var playerHand: [Card]
    private(set) var dealerHand: [Card]
    private(set) var playerScore: Int
    private(set) var dealerScore: Int
    private(set) var isGameOver: Bool = false
    private(set) var winner: String?
    private(set) var isPlayerStanding: Bool = false
    private(set) var currentBet: Int = 0
    private(set) var playerBalance: Int = 400
    private(set) var canDoubleDown: Bool = false
    private(set) var isTimeUp: Bool = false
    private(set) var isGameStarted: Bool = false
        
    init() {
        self.deck = BlackjackModel.createDeck()
        self.playerHand = []
        self.dealerHand = []
        self.playerScore = 0
        self.dealerScore = 0
        shuffleDeck()
        startNewGame()
    }
    
    mutating func placeBet(_ amount: Int) -> Bool {
        guard amount <= 500 && amount <= playerBalance && amount > 0 else {
            return false
        }
        currentBet = amount
        playerBalance -= amount
        if !isGameStarted {
            isGameStarted = true
        }
        return true
    }
    
    mutating func doubleDown() -> Bool {
        guard playerBalance >= currentBet && playerHand.count == 2 else {
            return false
        }
        
        playerBalance -= currentBet
        currentBet *= 2
        playerHits()
        if !isGameOver {
            playerStands()
        }
        return true
    }
        
    static func createDeck() -> [Card] {
        let suits = ["♠", "♣", "♦", "♥"]
        let values = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
        var deck: [Card] = []
        
        for suit in suits {
            for value in values {
                deck.append(Card(suit: suit, value: value))
            }
        }
        
        return deck
    }
    
    mutating func shuffleDeck() {
        deck.shuffle()
    }
    
    mutating func resetGame() {
            self.deck = BlackjackModel.createDeck()
            self.playerHand = []
            self.dealerHand = []
            self.playerScore = 0
            self.dealerScore = 0
            self.isGameOver = false
            self.winner = nil
            self.isPlayerStanding = false
            self.currentBet = 0
            self.canDoubleDown = false
            self.isTimeUp = false
            self.isGameStarted = false
            self.playerBalance = 400
            shuffleDeck()
            startNewGame()
        }
    
    mutating func startNewGame() {
        if playerBalance == 0 {
            isGameOver = true
            winner = "Game Over - Insufficient Funds"
            isTimeUp = true
            return
        }
        
        currentBet = 0
        playerHand = []
        dealerHand = []
        deck = BlackjackModel.createDeck()
        shuffleDeck()

        playerHand = [deck.removeFirst(), deck.removeFirst()]
        dealerHand = [deck.removeFirst(), deck.removeFirst()]
        playerScore = calculateScore(for: playerHand)
        dealerScore = calculateScore(for: dealerHand)
        isGameOver = false
        isPlayerStanding = false
        winner = nil
        canDoubleDown = true
    }
    
    
    private mutating func settleBet() {
        guard isGameOver else { return }

        if let winner = winner {
            if winner == "Player Wins" || winner == "Player Wins - Dealer Bust" {
                playerBalance += currentBet * 2  // Standardowe wygrane 1:1
            } else if winner == "Player Blackjack!" {
                playerBalance += Int(Double(currentBet) * 2.5)  // Blackjack płaci 3:2
            } else if winner == "Draw" {
                playerBalance += currentBet
            }
            
        }
    }
        
    
    mutating func playerHits() {
        canDoubleDown = false
        playerHand.append(deck.removeFirst())
        playerScore = calculateScore(for: playerHand)
        checkGameOver()
    }

    mutating func playerStands() {
        canDoubleDown = false
        isPlayerStanding = true
        dealerPlays()
    }
        
    mutating func dealerPlays() {
        
        while dealerScore < 17 {
            dealerHand.append(deck.removeFirst())
            dealerScore = calculateScore(for: dealerHand)
        }
        
        checkGameOver()
    }
        
    private func calculateScore(for hand: [Card]) -> Int {
        var score = 0
    
        for card in hand {
            if card.value == "A" {
                score += score + 11 <= 21 ? 11 : 1
            } else {
                score += card.numericValue
            }
            
        }
        
        return score
    }
    
    
    private mutating func checkGameOver() {
        let playerHasBlackjack = playerScore == 21 && playerHand.count == 2
        let dealerHasBlackjack = dealerScore == 21 && dealerHand.count == 2

        if playerHasBlackjack || dealerHasBlackjack {
            isGameOver = true
            if playerHasBlackjack && dealerHasBlackjack {
                winner = "Draw"
            } else if playerHasBlackjack {
                winner = "Player Blackjack!"
            } else {
                winner = "Dealer Blackjack!"
            }
        } else if playerScore > 21 {
            isGameOver = true
            winner = "Dealer Wins - Player Bust"
        } else if dealerScore > 21 {
            isGameOver = true
            winner = "Player Wins - Dealer Bust"
        } else if isPlayerStanding {
            isGameOver = true
            if playerScore > dealerScore {
                winner = "Player Wins"
            } else if dealerScore > playerScore {
                winner = "Dealer Wins"
            } else {
                winner = "Draw"
            }
        }
        
        settleBet()
    }
        
    
}
