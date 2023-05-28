//
//  GameView.swift
//  TicTacToe
//
//  Created by Roman on 5/27/23.
//

import SwiftUI

struct GameView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Text("Hello, World!")
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                Button("End game"){
                    dismiss()
                }
                .buttonStyle(.bordered)
            }
        }
        .navigationTitle("TicTacToe")
        .inNavigationStack()
        
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
