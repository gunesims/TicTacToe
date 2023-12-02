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
        checkIfAITurn()
    }
    
    func gameModeIsAI() -> Bool {
        switch game.gameMode {
        case .easyAI:
            return true
        case .mediumAI:
            return true
        case .hardAI:
            return true
        default:
            return false
        }
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
        self.game.boardDisabled = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.randomAIMove()
            self.game.boardDisabled = false
        }
        
    }
    
    func randomAIMove() {
        var randomMoveId = Int.random(in: 0..<9)
        
        while game.board[randomMoveId].symbol != nil {
            randomMoveId = Int.random(in: 0..<9)
        }
        
        if let squareForAIMove = getSquareFromId(id: randomMoveId) {
            squareClicked(square: squareForAIMove)
        }
    }
    
    func getSquareFromId(id: Int) -> Square? {
        guard id >= 0 && id < 9 else {
            return nil
        }
        for square in game.board {
            if square.id == id {
                return square
            }
        }
        
        return nil
    }
    
    func squareClicked(square: Square) {
        
        guard game.gameMode != nil else {
            return
        }
        
        guard game.playerOne != nil && game.playerTwo != nil else {
            return
        }
        
        guard square.symbol == nil else {
            return
        }
        
        guard game.gameState == .playing else {
            return
        }
        
        if game.gameEnded {
            return
        }
        
        guard game.isAnimationFinished else {
            return
        }
        
        game.boardDisabled = true
        addMoveToBoard(squareID: square.id)
        
        if checkWinner() {
            game.winner = game.currentPlayer
            game.gameState = .win
            checkScore()
            game.gameEnded = true
            return
        } else if checkDraw() {
            game.gameState = .draw
            checkScore()
            game.gameEnded = true
            return
        }
        
        game.boardDisabled = false
        toggleCurrentPlayer()
     
    }
    
    func addMoveToBoard(squareID: Int) {
        guard game.board[squareID].symbol == nil else {
            return
        }
        
        game.isAnimationFinished = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.game.isAnimationFinished = true
        }

        game.board[squareID].symbol = getCurrentPlayerSymbol()
        
        
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
        if let currentSymbol = game.currentPlayer?.symbol {
            return currentSymbol
        }
        
        return nil
    }
    
    func initializeBoard() {
        game.board.removeAll()
        
        for number in 0..<9 {
            game.board.append(Square(symbol: nil, id: number))
        }
    }
    
    func checkIfAITurn() {
        if gameModeIsAI() {
            if game.currentPlayer == game.playerTwo {
                getAIMove()
            }
        }
    }
    
    func restartGame() {
        initializeBoard()
        toggleCurrentPlayer()
        game.gameState = .playing
        
        game.boardDisabled = false
        checkIfAITurn()
    }
    
    func resetGame() {
        initializeBoard()
        resetScore()
        game.gameState = .playing
        game.boardDisabled = false
    }
    
    func toggleCurrentPlayer() {
        guard game.currentPlayer != nil else {
            return
        }
        
        if game.currentPlayer == game.playerOne {
            game.currentPlayer = game.playerTwo
            
            if gameModeIsAI() {
                getAIMove()
            }
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
