//
//  GameModels.swift
//  TicTacToe
//
//  Created by Roman on 5/27/23.
//

import Foundation
enum GameType{
    case single, bot, peer, undetermined
    var description: String{
        switch self {
        case .single:
            return "Share your iPhone/iPad and play against a friend."
        case .bot:
            return "Play against this iPhone/iPad."
        case .peer:
            return "Invite someone who has this app running to playre."
        case .undetermined:
            return "" 
        }
            
    }
}
