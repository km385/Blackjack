//
//  HeaderView.swift
//  blackjack
//
//  Created by student on 10/01/2025.
//

import SwiftUI

struct HeaderView: View {
    @ObservedObject var viewModel: BlackjackViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Blackjack")
                .font(.system(size: 40, weight: .bold))
                .padding(.top)
            
            ProgressView(value: Double(viewModel.timeRemaining), total: 30)
                .frame(height: 10)
                .padding(.horizontal)
        }
        .padding()
    }
}

#Preview {
    ContentView(viewModel: BlackjackViewModel())
}
