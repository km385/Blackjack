//
//  ActionButton.swift
//  blackjack
//
//  Created by student on 12/01/2025.
//

import SwiftUI

struct ActionButton: View {
    let title: String
    let color: Color
    
    var body: some View {
        Text(title)
            .font(.title2)
            .padding()
            .frame(minWidth: 80, maxWidth: .infinity) 
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(15)
            .minimumScaleFactor(0.8)
    }
}


