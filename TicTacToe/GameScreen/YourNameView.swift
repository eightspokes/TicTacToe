//
//  YourNameView.swift
//  TicTacToe
//
//  Created by Roman on 5/31/23.
//

import SwiftUI

struct YourNameView: View {
    @AppStorage("yourName") var yourName = ""
    @State private var userName = ""
    var body: some View {
        VStack(){
            Image("LaunchScreen")
                .resizable()
                .frame(width: 200,height: 200)
            Text("This is the name that would be associated with this device")
                .font(.title2)
            TextField("Your Name", text: $userName)
                .textFieldStyle(.roundedBorder)
            Button("Set"){
                yourName = userName
            }
            .buttonStyle(.borderedProminent)
            .disabled(userName.isEmpty)
            Spacer()
               
        }
        .padding(.horizontal)
        .navigationTitle("Tie Tac Toe")
        .inNavigationStack()
    }
}

struct YourNameView_Previews: PreviewProvider {
    static var previews: some View {
        YourNameView()
    }
}
