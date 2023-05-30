//
//  TicTacToeApp.swift
//  TicTacToe
//
//  Created by Roman on 5/27/23.
//

import SwiftUI

@main
struct AppEntry: App {
    
    @StateObject var game = GameService()
    
    var body: some Scene {
        WindowGroup {
            StartView()
                .environmentObject(game)
        }
    }
}
