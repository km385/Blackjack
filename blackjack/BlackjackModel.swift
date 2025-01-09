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
        
    mutating func startNewGame() {
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
        if winner?.contains("Player") ?? false {
            if winner?.contains("Blackjack") ?? false {
                playerBalance += Int(Double(currentBet) * 2.5)  // Blackjack pays 3:2
            } else {
                playerBalance += currentBet * 2  // Regular win pays 1:1
            }
        } else if winner?.contains("Draw") ?? false {
            playerBalance += currentBet  // Push returns the bet
        }
        // In case of dealer win, bet is already deducted
    }
        
    // Funkcja, która dodaje kartę do ręki gracza
    mutating func playerHits() {
        playerHand.append(deck.removeFirst())
        playerScore = calculateScore(for: playerHand)
        checkGameOver()
        print("Player hits \(playerScore)")
    }

    mutating func playerStands() {
        isPlayerStanding = true
        dealerPlays()
        print("Player hits \(playerScore)")
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
        var aces = 0
        
        // First count non-ace cards
        for card in hand {
            if card.value != "A" {
                score += card.numericValue ?? 0
            } else {
                aces += 1
            }
        }
        
        // Add aces optimally
        for _ in 0..<aces {
            if score + 11 <= 21 {
                score += 11
            } else {
                score += 1
            }
        }
        
        return score
    }
        
    private mutating func checkGameOver() {
        // Check for Blackjack (21 with first two cards)
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
            settleBet()
            return
        }
        
        if playerScore > 21 {
            isGameOver = true
            winner = "Dealer Wins - Player Bust"
            settleBet()
        } else if dealerScore > 21 {
            isGameOver = true
            winner = "Player Wins - Dealer Bust"
            settleBet()
        } else if isPlayerStanding {
            isGameOver = true
            if playerScore > dealerScore {
                winner = "Player Wins"
            } else if dealerScore > playerScore {
                winner = "Dealer Wins"
            } else {
                winner = "Draw"
            }
            settleBet()
        }
    }
        
    struct Card: Identifiable {
        let id = UUID()
        let suit: String
        let value: String
        
        var numericValue: Int? {
            switch value {
            case "A":
                return 11
            case "K", "Q", "J":
                return 10
            default:
                return Int(value)
            }
        }
    }
}
