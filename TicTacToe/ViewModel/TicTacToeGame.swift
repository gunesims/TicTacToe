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
//        self.game.boardDisabled = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.findWhichAIDifficultyMove()
        }
        
    }
    
    func findWhichAIDifficultyMove() {
        switch game.gameMode {
        case .easyAI:
            easyAIMove()
        case .mediumAI:
            mediumAIMove()
        case .hardAI:
            hardAIMove()
        default:
            easyAIMove()
        }
    }
    
    func easyAIMove() {
        if let move = getRandomMove() {
            squareClicked(row: move.0, col: move.1)
        }
    }
    
    func mediumAIMove() {
        if let move = getRandomMove() {
            squareClicked(row: move.0, col: move.1)
        }
    }
    
    func hardAIMove() {
        if let aiMove = minimax() {
            squareClicked(row: aiMove.0, col: aiMove.1)
            print("AI Best Move")
        } else {
            if let move = getRandomMove() {
                squareClicked(row: move.0, col: move.1)
                print("AI Random Move")
            }
        }
    }
    
    private var miniMaxBoard: [[Player?]] = Array(repeating: Array(repeating: .none, count: 3), count: 3)
    
    private func copyBoardForMiniMax() {
        for row in 0..<3 {
            for col in 0..<3 {
                miniMaxBoard[row][col] = game.board[row][col]
            }
        }
    }
    
    func minimax() -> (Int, Int)? {
        copyBoardForMiniMax()
        var bestScore = Int.min
        var bestMove: (Int, Int)? = nil
        
        for row in 0..<3 {
            for col in 0..<3 {
                if miniMaxBoard[row][col] == nil {
                    miniMaxBoard[row][col] = game.playerTwo
                    let score = minimaxHelper(depth: 0, isMaximizing: false)
                    miniMaxBoard[row][col] = nil
                    
                    if score > bestScore {
                        bestScore = score
                        bestMove = (row, col)
                    }
                }
            }
        }
        return bestMove
    }
    
    func minimaxHelper(depth: Int, isMaximizing: Bool) -> Int {
        if isWinnerMiniMax(player: game.playerTwo!) {
            return 1
        } else if isWinnerMiniMax(player: game.playerOne!) {
            return -1
        } else if isDrawMiniMax() {
            return 0
        }

        if isMaximizing {
            var maxEval = Int.min
            for row in 0..<3 {
                for col in 0..<3 {
                    if miniMaxBoard[row][col] == nil {
                        miniMaxBoard[row][col] = game.playerTwo
                        let eval = minimaxHelper(depth: depth + 1, isMaximizing: false)
                        miniMaxBoard[row][col] = nil
                        maxEval = max(maxEval, eval)
                    }
                }
            }
            return maxEval
        } else {
            var minEval = Int.max
            for row in 0..<3 {
                for col in 0..<3 {
                    if miniMaxBoard[row][col] == nil {
                        miniMaxBoard[row][col] = game.playerOne
                        let eval = minimaxHelper(depth: depth + 1, isMaximizing: true)
                        miniMaxBoard[row][col] = nil
                        minEval = min(minEval, eval)
                    }
                }
            }
            return minEval
        }
    }
    
    func isWinnerMiniMax(player: Player) -> Bool {
        for index in 0..<3 {
            if miniMaxBoard[index][0] == player && miniMaxBoard[index][1] == player && miniMaxBoard[index][2] == player {
                return true
            }
            
            if miniMaxBoard[0][index] == player && miniMaxBoard[1][index] == player && miniMaxBoard[2][index] == player {
                return true
            }
        }
        
        if miniMaxBoard[0][0] == player && miniMaxBoard[1][1] == player && miniMaxBoard[2][2] == player {
            return true
        }
        
        if miniMaxBoard[0][2] == player && miniMaxBoard[1][1] == player && miniMaxBoard[2][0] == player {
            return true
        }
        
        return false
    }
    
    func isDrawMiniMax() -> Bool {
        for row in 0..<3 {
            for col in 0..<3 {
                if miniMaxBoard[row][col] == nil {
                    return false
                }
            }
        }
        return true
    }
    
    
    
    
//    func isGameOver() -> Bool {
//        if isWinner(player) || isDraw() {
//            return true
//        }
//        
//        return false
//    }
    
    func getAvailableMoves() -> [(Int, Int)] {
        var movesLeft = [(Int, Int)]()
        
        for row in 0..<3 {
            for col in 0..<3 {
                if game.board[row][col] == nil {
                    movesLeft.append((row, col))
                }
            }
        }
        
        return movesLeft
    }

    func boardContains(player: Player) -> Bool {
        for row in 0..<3 {
            for col in 0..<3 {
                if game.board[row][col] == player {
                    return true
                }
            }
        }
        
        return false
    }
    
    func isWinner(player: Player) -> Bool {
        for index in 0..<3 {
            if game.board[index][0] == player && game.board[index][1] == player && game.board[index][2] == player {
                return true
            } else if game.board[0][index] == player && game.board[1][index] == player && game.board[2][index] == player {
                return true
            }
        }
        
        if game.board[0][0] == player && game.board[1][1] == player && game.board[2][2] == player {
            return true
        } else if game.board[0][2] == player && game.board[1][1] == player && game.board[2][0] == player {
            return true
        }
        
        return false
    }
    
    func isDraw() -> Bool {
        for row in 0..<3 {
            for col in 0..<3 {
                if game.board[row][col] == nil {
                    return false
                }
            }
        }
        return true
    }

    
    func updateScore() {
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
    
    func getRandomMove() -> (Int, Int)? {
        let moves = getAvailableMoves()
        
        if let randomMove = moves.randomElement() {
            return (randomMove.0, randomMove.1)
        } else {
            return nil
        }
    }
    
    func squareClicked(row: Int, col: Int) {
        guard game.gameMode != nil && game.playerOne != nil && game.playerTwo != nil else {
            return
        }
        
        guard game.board[row][col] == nil else {
            return
        }
        
        guard game.gameState == .playing else {
            return
        }
        
        guard !game.gameEnded else {
            return
        }
        
        guard game.isAnimationFinished else {
            return
        }

//        game.boardDisabled = true
        addMoveToBoard(row: row, col: col)
        checkGameStatus()
        toggleCurrentPlayer()
    }
    
    func checkGameStatus() {
        if let player = game.currentPlayer, isWinner(player: player) {
            game.winner = player
            game.gameState = .win
            updateScore()
            game.gameEnded = true
            return
        } else if isDraw() {
            game.gameState = .draw
            updateScore()
            game.gameEnded = true
            return
        }
    }
    
    
    func addMoveToBoard(row: Int, col: Int) {
        guard game.board[row][col] == nil else {
            return
        }
        
        game.isAnimationFinished = false
        
        game.board[row][col] = game.currentPlayer
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.game.isAnimationFinished = true
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
        game.board = Array(repeating: Array(repeating: .none, count: 3), count: 3)
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
        game.gameState = .playing
        toggleCurrentPlayer()
//        game.boardDisabled = false
    }
    
    func resetGame() {
        initializeBoard()
        resetScore()
        toggleCurrentPlayer()
        game.gameState = .playing
//        game.boardDisabled = false
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
//            game.boardDisabled = false
        }
    }
}
