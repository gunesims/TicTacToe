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
    var boardPositions = Set<Int>()
    
    static func ==(lhs: Player, rhs: Player) -> Bool {
        return lhs.symbol == rhs.symbol && lhs.boardPositions == rhs.boardPositions
    }
}

struct Square: Hashable {
    var symbol: Symbol?
    let id: Int
    
}

struct TicTacToe {
    let winningCombinations = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    
    var board = Array<Square>()
    var boardDisabled = false
    var gameEnded = false
    var isAnimationFinished = true
    
    var playerOneScore = 0
    var playerTwoScore = 0
    var drawScore = 0
    
    var currentPlayer: Player?
    var playerOne: Player?
    var playerTwo: Player?
    var winner: Player?
    
    var gameMode: GameMode?
    var gameState: GameState?
    
    init() {
        for number in 0..<9 {
            self.board.append(Square(symbol: nil, id: number))
        }
    }
}


