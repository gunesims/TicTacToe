//
//  TicTacToeGame.swift
//  TicTacToe
//
//  Created by Crossley Rozario on 7/3/23.
//  Copyright © 2023 Crossley Rozario. All rights reserved.
//

import Foundation


class TicTacToeGame: ObservableObject {
    @Published var game = TicTacToe()
    
    func squareClicked(square: Square) {
        if game.gameState == .none {
            initializeGame()
        }
        
        if square.symbol != .none{
            return
        }
        
        game.board[square.id].symbol = getCurrentPlayerSymbol()
        toggleCurrentPlayer()
        print(game.board)
    }
    
    func initializeGame() {
        game.gameState = .playing
        game.currentPlayer = game.playerOne
    }
    
    func getCurrentPlayerSymbol() -> Symbol {
        game.currentPlayer == game.playerOne ? game.playerOneSymbol : game.playerTwoSymbol
    }
    
    func toggleCurrentPlayer() {
        if game.currentPlayer == Player.none {
            return
        } else if game.currentPlayer == game.playerOne {
            game.currentPlayer = game.playerTwo
        } else {
            game.currentPlayer = game.playerOne
        }
    }
 
}
