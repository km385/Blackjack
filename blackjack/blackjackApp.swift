//
//  blackjackApp.swift
//  blackjack
//
//  Created by student on 08/01/2025.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
         
    static var orientationLock = UIInterfaceOrientationMask.all
 
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}

@main
struct blackjackApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var game = BlackjackViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
