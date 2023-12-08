//
//  TicTacToe.swift
//  TicTacToe
//
//  Created by Crossley Rozario on 6/26/23.
//  Copyright © 2023 Crossley Rozario. All rights reserved.
//

import Foundation

enum Symbol: String {
    case x = "X"
    case o = "O"
}

enum GameMode {
    case easyAI
    case mediumAI
    case hardAI
    case friend
}

enum AIGameMode {
    case easy
    case medium
    case hard
}

enum SimpleGameMode {
    case AI
    case friend
}

enum GameState {
    case playing
    case win
    case draw
}

struct Player: Equatable {
    var symbol: Symbol
    
    static func ==(lhs: Player, rhs: Player) -> Bool {
        return lhs.symbol == rhs.symbol
    }
}

struct TicTacToe {    
    var board: [[Player?]] = Array(repeating: Array(repeating: .none, count: 3), count: 3)
    var boardDisabled = false
    var gameEnded = false
    var isAnimationFinished = true
    
    var playerOneScore = 0
    var playerTwoScore = 0
    var drawScore = 0
    
    var currentPlayer: Player? {
        didSet {
            if currentPlayer == playerTwo {
                boardDisabled = true
                print("Board Disabled")
            } else if currentPlayer == playerOne {
                boardDisabled = false
                print("Board Enabled")
            }
        }
    }
    var playerOne: Player?
    var playerTwo: Player?
    var winner: Player?
    
    var gameMode: GameMode?
    var gameState: GameState?
}


