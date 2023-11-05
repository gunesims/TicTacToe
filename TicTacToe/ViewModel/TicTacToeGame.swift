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
    
    func setGameMode(gameMode: GameMode) {
        game.gameMode = gameMode
    }
    
    func setSymbols(selectedSymbol: Symbol) {
        if selectedSymbol == .x {
            game.playerOneSymbol = .x
            game.playerTwoSymbol = .o
        } else {
            game.playerOneSymbol = .o
            game.playerTwoSymbol = .x
        }
    }
    
    func squareClicked(square: Square) {
        guard game.gameMode != .none else {
            return
        }
        
        guard game.playerOneSymbol != .none && game.playerTwoSymbol != .none else {
            return
        }
        
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
            checkScore()
            game.gameEnded = true
        } else if checkDraw() {
            game.gameState = .draw
            checkScore()
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
    
    func checkScore() {
        if game.gameState == .win {
            if game.currentPlayer == .playerOne {
                game.playerOneScore += 1
            } else {
                game.playerTwoScore += 1
            }
        } else if game.gameState == .draw {
            game.drawScore += 1
        }
    }
    
    func initializeGame() {
        game.gameState = .playing
        game.currentPlayer = game.playerOne
    }
    
    func resetScore() {
        game.playerOneScore = 0
        game.playerTwoScore = 0
        game.drawScore = 0
    }
    
    func getPlayerOneScore() -> Int {
        game.playerOneScore
    }
    
    func getPlayerTwoScore() -> Int {
        game.playerTwoScore
    }
    
    
    func getCurrentPlayerSymbol() -> Symbol {
        game.currentPlayer == game.playerOne ? game.playerOneSymbol : game.playerTwoSymbol
    }
    
    func resetBoard() {
        game.board.removeAll()
        
        for number in 0..<9 {
            game.board.append(Square(symbol: .none, id: number))
        }
    }
    
    func resetGame() {
        resetBoard()
        resetScore()
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
