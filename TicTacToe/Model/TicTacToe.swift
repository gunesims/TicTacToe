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
    case none = ""
}

enum Player {
    case userOne
    case userTwo
    case computer
    case none
}

enum GameState {
    case playing
    case win
    case draw
    case none
}

struct Square: Hashable {
    var symbol: Symbol
    let id: Int
}


struct TicTacToe {

    var board = Array<Square>()
    
    var gameState = GameState.none
    var currentPlayer = Player.none
    
    var playerOne = Player.userOne
    var playerTwo = Player.userTwo
    var playerOneSymbol = Symbol.x
    var playerTwoSymbol = Symbol.o
    
    let winningCombinations = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    
    init() {
        for number in 0..<9 {
            self.board.append(Square(symbol: .none, id: number))
        }
    }
    
    func winnerFound() -> Bool {
//        var currentCombo: Array<Int>
//
//        for winningCombination in winningCombinations {
//            currentCombo = winningCombination
//
//            for combo in winningCombination {
//
//            }
//        }

        return false
    }
}


