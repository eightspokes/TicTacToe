//
//  GameService.swift
//  TicTacToe
//
//  Created by Roman on 5/28/23.
//

import SwiftUI

@MainActor
class GameService: ObservableObject{
    @Published var player1 = Player(gamePiece: .x, name: "Player 1")
    @Published var player2 = Player(gamePiece: .o, name: "Player 2")
    @Published var possibleMoves = Move.all
    @Published var gameOver = false
    @Published var gameBoard = GameSquare.reset
    @Published var isThinking = false
    var gameType = GameType.single
    
    var currentPlayer: Player{
        if player1.isCurrent{
            print("Current player 1")
            return player1
        }else{
            print("Current player 2")
            return player2
        }
    }
    var gameStarted: Bool {
        player1.isCurrent || player2.isCurrent
    }
    var boardDisabled: Bool{
        gameOver || !gameStarted || isThinking
    }
    
    func setupGame(gameType: GameType, player1Name: String, player2Name: String){
        switch gameType{
        case .single:
            self.gameType = .single
            player2.name = player2Name
        case .peer:
            self.gameType = .peer
        case .bot:
            self.gameType = .bot
            player2.name = UIDevice.current.name
        case .undetermined:
            break
        }
        player1.name = player1Name
    }
    func reset(){
        player1.isCurrent = false
        player2.isCurrent = false
        player1.moves.removeAll()
        player2.moves.removeAll()
        gameOver = false
        possibleMoves = Move.all
        gameBoard = GameSquare.reset
    }
    func updateMoves(index: Int){
        if player1.isCurrent {
            player1.moves.append(index + 1)
            gameBoard[index].player = player1
        }else{
            player2.moves.append(index + 1 )
            gameBoard[index].player = player2
        }
    }
    func checkIfWinner(){
        if player1.isWinner || player2.isWinner{
            gameOver = true
        }else{
           togglecurrent()
        }
    }
    func togglecurrent(){
        print("Toggling current: player1 \(player1.isCurrent) ,player2 \(player2.isCurrent)")
        player1.isCurrent.toggle()
        player2.isCurrent.toggle()
        print("Toggled current: player1 \(player2.isCurrent) ,player \(player2.isCurrent)")
    }
    func makeMove(at index: Int){
        if gameBoard[index].player == nil {
            withAnimation {
                updateMoves(index: index)
            }
            checkIfWinner()
            if !gameOver{
                if let mathchingIndex = possibleMoves.firstIndex(where: {$0 == (index + 1)}){
                    possibleMoves.remove(at: mathchingIndex)
                }
                if gameType == .bot && currentPlayer.name == player2.name{
                    Task{
                        await deviceMove()
                    }
                }
                
            }
            
            if possibleMoves.isEmpty{
                gameOver = true
            }
        }
    }
    func deviceMove() async {
        isThinking.toggle()
        try? await Task.sleep(nanoseconds: 1000_000_000)
        if let move = possibleMoves.randomElement(){
            if let matchingIndex = Move.all.firstIndex(where: {$0 == move}){
                makeMove(at: matchingIndex)
            }
        }
        isThinking.toggle()
    }
}
