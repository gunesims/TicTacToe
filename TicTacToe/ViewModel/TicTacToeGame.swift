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
        
        if game.gameEnded {
            return
        }
        
        game.board[square.id].symbol = getCurrentPlayerSymbol()
        
        if checkWinner() {
            game.winner = game.currentPlayer
            game.gameState = .win
            game.gameEnded = true
        } else if checkDraw() {
            game.gameState = .draw
            game.gameEnded = true
        } else {
            toggleCurrentPlayer()
        }
    }
    
    func checkWinner() -> Bool {

        for combo in game.winningCombinations {
            let currentSymbol = game.board[combo[0]].symbol
            var counter = 0
            
            for index in combo {
                if currentSymbol == .none {
                    break
                } else if currentSymbol == game.board[index].symbol {
                    counter += 1
                } else {
                    break
                }
            }
            
            if counter == 3 {
                return true
            }
        }

        return false
    }
    
    func checkDraw() -> Bool {
        for square in game.board {
            if square.symbol == Symbol.none {
                return false
            }
        }
        
        return true
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
