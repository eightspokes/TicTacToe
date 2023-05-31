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
    @AppStorage("yourName") var yourName = ""
    var body: some Scene {
        WindowGroup {
            if yourName.isEmpty{
               YourNameView(yourName: yourName)
                
            }else{
                StartView(yourName: yourName)
                    .environmentObject(game)
            }
            
            
        }
    }
}
