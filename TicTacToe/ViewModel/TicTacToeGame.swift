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
    
    func setupPlayers(selectedSymbol: Symbol) {
        game.playerOne = Player(symbol: selectedSymbol)
        
        if selectedSymbol == .o {
            game.playerTwo = Player(symbol: .x)
        } else {
            game.playerTwo = Player(symbol: .o)
        }
    }
    
    func startGame() {
        resetGame()
        chooseFirstMovePlayer()
        game.gameState = .playing
        
    }
    
    func chooseFirstMovePlayer() {
        let firstMovePlayerNumber = Int.random(in: 0..<2)
        
        if firstMovePlayerNumber == 0 {
            game.currentPlayer = game.playerOne
        } else {
            game.currentPlayer = game.playerTwo
        }
    }
    
    func getAIMove() {
        
    }
    
    func squareClicked(square: Square) {
        guard game.gameMode != nil else {
            return
        }
        
        guard game.playerOne != nil && game.playerTwo != nil else {
            return
        }
        
        if square.symbol != nil {
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
            if square.symbol == nil {
                return false
            }
        }
        
        return true
    }
    
    func checkScore() {
        if game.gameState == .win {
            if game.currentPlayer == game.playerOne {
                game.playerOneScore += 1
            } else {
                game.playerTwoScore += 1
            }
        } else if game.gameState == .draw {
            game.drawScore += 1
        }
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
    
    
    func getCurrentPlayerSymbol() -> Symbol? {
        game.currentPlayer == game.playerOne ? game.playerOne?.symbol : game.playerTwo?.symbol
    }
    
    func initializeBoard() {
        game.board.removeAll()
        
        for number in 0..<9 {
            game.board.append(Square(symbol: nil, id: number))
        }
    }
    
    func resetGame() {
        initializeBoard()
        resetScore()
    }
    
    func toggleCurrentPlayer() {
        if game.currentPlayer == nil {
            return
        } else if game.currentPlayer == game.playerOne {
            game.currentPlayer = game.playerTwo
        } else {
            game.currentPlayer = game.playerOne
        }
    }
 
//    func score(game, depth) {
//        if game.win(player) {
//            return 10 - depth
//        } else if game.win(opponent) {
//            return depth - 10
//        } else {
//            return 0
//        }
//    }
//    
//    func minimax(game, depth) {
//        return score(game,)
//        
//    }
}
