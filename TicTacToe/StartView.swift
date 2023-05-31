//
//  ContentView.swift
//  TicTacToe
//
//  Created by Roman on 5/27/23.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var game: GameService
    @State private var gameType: GameType = .undetermined
    @AppStorage ("yourName") private var yourName = ""
    @State private var opponentName = ""
    @FocusState private var focus: Bool
    @State private var startGame = false
    @State private var newName = ""
    @State private var changeName = false
    
    init(yourName: String){
        self.yourName = yourName
    }
    var body: some View {
        VStack {
            Picker("Select Game", selection: $gameType){
                Text("Select Game Type").tag(GameType.undetermined)
                Text("Two Sharing device").tag(GameType.single)
                Text("Challenge your device").tag(GameType.bot)
                Text("Challenge a friend").tag(GameType.peer)
              
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(lineWidth: 2))
            Text(gameType.description)
                .padding()
            
            VStack{
                switch gameType {
                case .single:
                    VStack{
                        TextField("Opponent's name", text: $opponentName)
                    }
                case .bot:
                   EmptyView()
                case .peer:
                    EmptyView()
                case .undetermined:
                    EmptyView()
                }
            }
            .padding()
            .textFieldStyle(.roundedBorder)
            .focused($focus)
            .frame(width: 350)
            if gameType != .peer{
                Button("Start Game"){
                    game.setupGame(gameType: gameType, player1Name: yourName, player2Name: opponentName)
                    focus = false
                    startGame = true
                }
                .buttonStyle(.borderedProminent)
                .disabled(
                    gameType == .undetermined ||
                
                    gameType == .single && opponentName.isEmpty
                )
                
                Image("LaunchScreen")
                    .resizable()
                    .frame(width: 200, height: 200)
                Text("Your current name is \(self.yourName)")
                Button("Change my name"){
                    changeName.toggle()
                }
                .buttonStyle(.bordered)
                
                
                Spacer()
            }
            
        }
        .padding()
        .navigationTitle("Tic Tac Toe")
        .fullScreenCover(isPresented: $startGame){
            GameView()
        }
        .alert("Change name", isPresented: $changeName, actions: {
            TextField("New name", text: $newName)
            Button("OK", role: .destructive){
                yourName = newName
                exit(-1) // to restart the app
            }
            Button("Cancel", role: .cancel){
                
            }
        }, message: {
            Text("Tapping on the OK button will quit the application so you can relaunch to use your changed name")
        })
        
        
        
        
        .onAppear{
            game.reset()
        }
        .inNavigationStack()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView(yourName: "Sample")
            .environmentObject(GameService())
    }
}
