//
//  GameView.swift
//  TicTacToe
//
//  Created by Crossley Rozario on 6/25/23.
//  Copyright © 2023 Crossley Rozario. All rights reserved.
//

import SwiftUI


struct GameView: View {
    var body: some View {
        BoardView()
    }
}

struct BoardView: View {
    @StateObject private var ticTacToeGame = TicTacToeGame()
    
    var body: some View {
        
        VStack {
            Spacer()
            HStack(spacing: 50) {
                VStack {
                    Text("Player One")
                    Text("\(ticTacToeGame.getPlayerOneScore())")
                }
                VStack {
                    Text("Player Two")
                    Text("\(ticTacToeGame.getPlayerTwoScore())")
                }
            }
            
            Spacer()
            
            LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                ForEach(ticTacToeGame.game.board, id: \.self) { item in
                    SquareView(square: item)
                        .onTapGesture {
                            ticTacToeGame.squareClicked(square: item)
                        }
                }
            }
            .alert("Game Over", isPresented: $ticTacToeGame.game.gameEnded) {
                Button("OK", role: .cancel) {
                    ticTacToeGame.resetBoard()
                }
            } message: {
                Text(ticTacToeGame.game.gameState == .win ? "Winner is \(ticTacToeGame.game.winner == .playerOne ? "User One" : "User Two")" : "It's a draw")
            }
            
            Spacer()
            
            VStack(spacing: 30) {
                Button {
                    ticTacToeGame.resetBoard()
                } label: {
                    Text("Restart Game")
                }
                
                Button {
                    ticTacToeGame.resetScore()
                } label: {
                    Text("Reset Score")
                }
            }
            
            Spacer()
        }
    }
    
    
    
}

struct SquareView: View {
    let square: Square
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.clear)
                .border(.black, width: 2.0)
                .frame(width: 100,height: 100)
            Text(square.symbol.rawValue)
                .font(.system(size: 35, weight: .bold))
        }
        .background(.white)
    }
}


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}



