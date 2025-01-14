//
//  Card.swift
//  blackjack
//
//  Created by student on 14/01/2025.
//

import Foundation

struct Card: Identifiable {
    let id = UUID()
    let suit: String
    let value: String
    
    var numericValue: Int {
        switch value {
        case "A":
            return 11
        case "K", "Q", "J":
            return 10
        default:
            return Int(value) ?? 0
        }
    }
}
