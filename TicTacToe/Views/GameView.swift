//
//  GameView.swift
//  TicTacToe
//
//  Created by Crossley Rozario on 6/25/23.
//  Copyright © 2023 Crossley Rozario. All rights reserved.
//

import SwiftUI

struct GameView: View {
    var gameMode: GameMode
    var selectedSymbol: Symbol
    
    @EnvironmentObject var ticTacToeGame: TicTacToeGame
    
    var body: some View {
        VStack {
            Spacer()
            
            ScoreView()
            
            Spacer()
            
            BoardView()
            
            Spacer()
            
            ButtonView()
            
            Spacer()
        }
        .background(Color.background)
        .onAppear {
            ticTacToeGame.setGameMode(gameMode: gameMode)
            ticTacToeGame.setupPlayers(selectedSymbol: selectedSymbol)
            ticTacToeGame.startGame()
            
        }
    }
}

struct ScoreView: View {
    @EnvironmentObject var ticTacToeGame: TicTacToeGame
    
    var body: some View {
        HStack(spacing: 20) {
            VStack(spacing: 10) {
                Text("You")
                    .foregroundStyle(playerOneSymbolColor)
                Text("\(ticTacToeGame.getPlayerOneScore()) wins")
            }
            .foregroundColor(.button)
            .bold()
            .font(.title2)
            
            VStack(spacing: 10) {
                Text(playerTwoSelectedPlayer)
                    .foregroundStyle(playerTwoSymbolColor)
                Text("\(ticTacToeGame.getPlayerTwoScore()) wins")
            }
            .foregroundColor(.button)
            .bold()
            .font(.title2)
        }
    }
    
    var playerOneSymbolColor: Color {
        ticTacToeGame.game.playerOne?.symbol == Symbol.x ? Color.XSymbol : Color.OSymbol
    }
    
    var playerTwoSymbolColor: Color {
        ticTacToeGame.game.playerOne?.symbol != Symbol.x ? Color.XSymbol : Color.OSymbol
    }
    
    var playerTwoSelectedPlayer: String {
        if let gameMode = ticTacToeGame.game.gameMode {
            switch gameMode {
            case .easyAI:
                return "Easy AI"
            case .mediumAI:
                return "Medium AI"
            case .hardAI:
                return "Hard AI"
            case .friend:
                return "Friend"
            }
        } else {
            return "None"
        }
        
    }
    
}

struct BoardView: View {
    @EnvironmentObject var ticTacToeGame: TicTacToeGame
    @State private var gameOver = false
    
    let columns = [GridItem(.flexible(),spacing: 10), GridItem(.flexible(),spacing: 10), GridItem(.flexible(),spacing: 10)]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(ticTacToeGame.game.board, id: \.self) { item in
                SquareView(square: item)
                    .onTapGesture {
                        ticTacToeGame.squareClicked(square: item)
                    }
            }
        }
        .background(Color.boardGrid)
        .padding()
        .alert("Game Over", isPresented: $ticTacToeGame.game.gameEnded) {
            Button("OK", role: .cancel) {
                ticTacToeGame.initializeBoard()
            }
        } message: {
            Text(Alerts.winnerMessage(game: ticTacToeGame.game))
        }
        
    }
}

struct Alerts {
    static func winnerMessage(game: TicTacToe) -> String {
        game.gameState == .win ? "Winner is \(game.winner == game.playerOne ? "You" : game.gameMode == .friend ? "Friend" : "AI")" : "It's a draw"
    }
}

struct SquareView: View {
    let square: Square
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.clear)
            if square.symbol == .o {
                OSymbolView()
                    .padding(20)
            } else if square.symbol == .x {
                XSymbolView()
                    .padding(25)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .aspectRatio(1, contentMode: .fit)
        .background(Color.background)
    }
}



struct ButtonView: View {
    @EnvironmentObject var ticTacToeGame: TicTacToeGame
    
    var body: some View {
        VStack(spacing: 15) {
            Text(getCurrentTurn())
                .foregroundStyle(getCurrentPlayerColor())
                .bold()
                .font(.title2)
            
            HStack(spacing: 10) {
                Button {
                    ticTacToeGame.initializeBoard()
                } label: {
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.button)
                        Text("Restart Game")
                            .bold()
                    }
                    .frame(width: 150, height: 50)
                    .foregroundColor(.background)
                    .bold()
                }
                
                Button {
                    ticTacToeGame.resetScore()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.button)
                        Text("Reset Score")
                            .bold()
                    }
                    .frame(width: 150, height: 50)
                    .foregroundColor(.background)
                    .bold()
                }
            }
        }
    }
    
    func getCurrentTurn() -> String {
        ticTacToeGame.game.currentPlayer == ticTacToeGame.game.playerOne ? "Your Turn" : ticTacToeGame.game.gameMode == .friend ? "Friend's Turn" : "AI's Turn"
    }
    
    func getCurrentPlayerColor() -> Color {
        return ticTacToeGame.game.currentPlayer == ticTacToeGame.game.playerOne ? ticTacToeGame.game.playerOne?.symbol == Symbol.x ? Color.XSymbol : Color.OSymbol : ticTacToeGame.game.playerOne?.symbol != Symbol.x ? Color.XSymbol : Color.OSymbol
    }
}

struct OSymbolView: View {
    @State private var drawingStroke: CGFloat = 0.0
    
    let animation = Animation
        .easeOut(duration: 0.5)
    
    var body: some View {
        Circle()
            .trim(from: CGFloat(0), to: drawingStroke)
            .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round))
            .fill(Color.OSymbol)
            .animation(animation, value: drawingStroke)
            .rotationEffect(.degrees(-90))
            .task {
                drawingStroke = CGFloat(1.0)
            }
    }
}

struct XSymbolView: View {
    @State private var drawingStroke: CGFloat = 0.0
    
    let animation = Animation
        .easeOut(duration: 0.5)
    
    var body: some View {
        XSymbol()
            .trim(from: 0, to: CGFloat(drawingStroke))
            .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round))
            .fill(Color.XSymbol)
            .animation(animation, value: drawingStroke)
            .onAppear {
                drawingStroke = CGFloat(1.0)
            }
    }
}

struct XSymbol: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        
        return path
    }
}

extension Color {
    static var background: Color {
        //        Color(red: 246/255, green: 244/255, blue: 235/255)
        //        Color(red: 241/255, green: 246/255, blue: 249/255)
        Color.white
    }
    
    static var button: Color {
        //        Color(red: 116/255, green: 155/255, blue: 194/255)
        //        Color(red: 43/255, green: 45/255, blue: 66/255)
        //        Color(red: 25/255, green: 50/255, blue: 60/255)
        Color(red: 254/255, green: 168/255, blue: 47/255)
    }
    
    static var boardGrid: Color {
        Color(red: 25/255, green: 50/255, blue: 60/255)
    }
    
    static var XSymbol: Color {
        Color(red: 26/255, green: 172/255, blue: 172/255)
        //        Color(red: 43/255, green: 45/255, blue: 66/255)
    }
    
    static var OSymbol: Color {
        Color(red: 232/255, green: 106/255, blue: 146/255)
    }
}

#Preview {
    GameView(gameMode: .easyAI, selectedSymbol: Symbol.x)
        .environmentObject(TicTacToeGame())
}

