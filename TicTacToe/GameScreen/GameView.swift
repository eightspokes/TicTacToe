//
//  GameView.swift
//  TicTacToe
//
//  Created by Roman on 5/27/23.
//

import SwiftUI

struct GameView: View {
    //calling dismiss as a function will result this view to be dismissed
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var game: GameService
    var body: some View {
        VStack {
            if [game.player1.isCurrent, game.player2.isCurrent].allSatisfy{$0 == false}{
                Text("Select a player to start")
            }
            HStack{
                Button(game.player1.name){
                    game.player1.isCurrent = true
                }
                .buttonStyle(PlayerButtonStyle(isCurrent: game.player1.isCurrent))
                Button(game.player2.name){
                    game.player2.isCurrent = true
                }
                .buttonStyle(PlayerButtonStyle(isCurrent: game.player2.isCurrent))
            }
            .disabled(game.gameStarted)
            VStack{
                HStack{
                    ForEach(0...2, id: \.self){ index in
                        SquareView(index: index)
                    }
                }
                HStack{
                    ForEach(3...5, id: \.self){ index in
                        SquareView(index: index)
                    }
                }
                HStack{
                    ForEach(6...8, id: \.self){ index in
                        SquareView(index: index)
                    }
                }
            }
            .disabled(game.boardDisabled)
            VStack{
                if game.gameOver{
                    Text("Game Over")
                    if game.possibleMoves.isEmpty{
                        Text("Nobody wins")
                    }else{
                        Text("\(game.currentPlayer.name) wins")
                    }
                    Button("New game"){
                        game.reset()
                    }.buttonStyle(.borderedProminent)
                }
                
            }.font(.largeTitle)
            Spacer()
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
            .environmentObject(GameService())
    }
}

struct PlayerButtonStyle: ButtonStyle {
    let isCurrent: Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(8)
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(isCurrent ? Color.gray : Color.blue)
            )
            .foregroundColor(.white)
    }
}
