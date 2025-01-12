import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: BlackjackViewModel

    var body: some View {
        VStack(spacing: 20) {
            BalanceView(viewModel: viewModel)

            HandView(
                title: "Dealer's Hand:",
                viewModel: viewModel,
                isDealer: true
            )

            HandView(
                title: "Your Hand:",
                viewModel: viewModel,
                isDealer: false
            )

            if viewModel.isGameOver {
                GameOverView(viewModel: viewModel)
                
            } else {
                GameControlsView(viewModel: viewModel)
            }
        }
        .padding()
    }
}

#Preview {
    GameView(viewModel: BlackjackViewModel())
    
}
