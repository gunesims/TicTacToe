//
//  TicTacToe.swift
//  TicTacToe
//
//  Created by Crossley Rozario on 6/26/23.
//  Copyright © 2023 Crossley Rozario. All rights reserved.
//

import Foundation

enum Players {
    case user
    case computer
    case none
}

enum Sign: String {
    case x = "X"
    case o = "0"
    case none = ""
}




struct TicTacToe {
    var playerPick = Sign.none
    var currentPlayerTurn = Players.none
    var board = Array(repeating: Sign.none, count: 9)
    let winningCombinations = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    
}
