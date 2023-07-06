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
    @State private var tictactoe = TicTacToe()
    
    var body: some View {
//        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
//            ForEach(tictactoe.board, id: \.self) { item in
//                SquareView(sign: Sign.none)
//
//            }
//
//        }
       
        Grid {

            GridRow {
                SquareView(sign: Sign.x)
                SquareView(sign: Sign.x)
                SquareView(sign: Sign.x)
            }

            GridRow {
                SquareView(sign: Sign.x)
                SquareView(sign: Sign.x)
                SquareView(sign: Sign.x)
            }

            GridRow {
                SquareView(sign: Sign.x)
                SquareView(sign: Sign.x)
                SquareView(sign: Sign.x)
            }
        }
    }
}

struct SquareView: View {
    var sign: Sign
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.clear)
                .border(.black, width: 2.0)
                .frame(width: 100,height: 100)
            Text(sign.rawValue)
                .font(.system(size: 35, weight: .bold))
        }
        .onTapGesture {
            
        }
        
        
    }
}


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}



