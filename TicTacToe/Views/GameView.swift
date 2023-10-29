//
//  GameView.swift
//  TicTacToe
//
//  Created by Crossley Rozario on 6/25/23.
//  Copyright © 2023 Crossley Rozario. All rights reserved.
//

import SwiftUI

struct GameView: View {
    @StateObject private var ticTacToeGame = TicTacToeGame()
    
    var body: some View {
        VStack {
            Spacer()
            
            ScoreView(ticTacToeGame: ticTacToeGame)
            
            Spacer()
            
            BoardView(ticTacToeGame: ticTacToeGame)
            
            Spacer()
            
            ButtonView(ticTacToeGame: ticTacToeGame)
            
            Spacer()
        }
        .background(Color.primaryColor)
    }
}

struct BoardView: View {
    @StateObject var ticTacToeGame: TicTacToeGame
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
        .background(.black)
        .padding()
        .alert("Game Over", isPresented: $ticTacToeGame.game.gameEnded) {
            Button("OK", role: .cancel) {
                ticTacToeGame.resetBoard()
            }
        } message: {
            Text(ticTacToeGame.game.gameState == .win ? "Winner is \(ticTacToeGame.game.winner == .playerOne ? "Player One" : "Player Two")" : "It's a draw")
        }
    }
}

struct ScoreView: View {
    @StateObject var ticTacToeGame: TicTacToeGame
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.secondaryColor, lineWidth: 2)
            
            HStack(spacing: 20) {
                VStack(spacing: 10) {
                    Text("Player One")
                    Text("\(ticTacToeGame.getPlayerOneScore())")
                }
                .foregroundColor(.secondaryColor)
                .bold()
                .font(.title2)
                
                
                Divider()
                    .background(Color.secondaryColor)
                
                VStack(spacing: 10) {
                    Text("Player Two")
                    Text("\(ticTacToeGame.getPlayerTwoScore())")
                }
                .foregroundColor(.secondaryColor)
                .bold()
                .font(.title2)
            }
        }
        .frame(width: 300, height: 120)
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
        .background(Color.primaryColor)
    }
}



struct ButtonView: View {
    @StateObject var ticTacToeGame: TicTacToeGame
    
    var body: some View {
        VStack(spacing: 15) {
            Button {
                ticTacToeGame.resetBoard()
            } label: {
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.secondaryColor)
                    Text("Restart Game")
                }
                .frame(width: 150, height: 50)
                .foregroundColor(.primaryColor)
                .bold()
            }
            
            Button {
                ticTacToeGame.resetScore()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.secondaryColor)
                    Text("Reset Score")
                }
                .frame(width: 150, height: 50)
                .foregroundColor(.primaryColor)
                .bold()
            }
        }
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
    static var primaryColor: Color {
//        Color(red: 246/255, green: 244/255, blue: 235/255)
        Color(red: 241/255, green: 246/255, blue: 249/255)
    }
    
    static var secondaryColor: Color {
        Color(red: 116/255, green: 155/255, blue: 194/255)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}



