import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: BlackjackViewModel
    @State private var showAlert = false
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
            
            VStack {
                HeaderView(viewModel: viewModel)
                
                if viewModel.currentBet == 0 {
                    BettingView(viewModel: viewModel)
                } else {
                    GameView(viewModel: viewModel)
                }
            }
        }
        .onChange(of: viewModel.isTimeUp) {
            showAlert = true
        }
        .alert("Koniec gry", isPresented: $showAlert) {
            Button("Zagraj ponownie") {
                viewModel.resetGame()
            }
        } message: {
            Text("Twój wynik: \(String(viewModel.playerBalance))")
        }
        .onAppear {
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            AppDelegate.orientationLock = .portrait
        }.onDisappear {
            AppDelegate.orientationLock = .all
        }
        
        
    }
}

#Preview("Portrait", traits: .portrait) {
    ContentView(viewModel: BlackjackViewModel())
        
}
