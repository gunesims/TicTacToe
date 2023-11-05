//
//  HomeView.swift
//  TicTacToe
//
//  Created by Crossley Rozario on 10/30/23.
//  Copyright © 2023 Crossley Rozario. All rights reserved.
//

import SwiftUI

struct HomeView: View {
//    @EnvironmentObject var ticTacToeGame: TicTacToeGame
    @State private var selectedSymbol = Symbol.x
    
    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                Text("Select Game Mode")
                    .font(.title)
                    .bold()
                
                NavigationLink {
                    GameView(gameMode: .ai, selectedSymbol: selectedSymbol)
                } label: {
                    Text("AI")
                        .font(.largeTitle)
                        .frame(width: 200)
                        .foregroundStyle(.white)
                        .padding(5)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .fill(Color.button))
                }
                
                NavigationLink {
                    GameView(gameMode: .friend, selectedSymbol: selectedSymbol)
                } label: {
                    Text("Friend")
                        .font(.largeTitle)
                        .frame(width: 200)
                        .foregroundStyle(.white)
                        .padding(5)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .fill(Color.button))
                }
                
                HStack {
                    Text("You")
                    SymbolPicker(selectedSymbol: $selectedSymbol)
                        .frame(width: 200)
                }
            }
        }
    }
}

struct SymbolPicker: View {
    @Binding var selectedSymbol: Symbol
    
    var body: some View {
        Picker("Symbol", selection: $selectedSymbol) {
            Text("X")
                .tag(Symbol.x)
            Text("O")
                .tag(Symbol.o)
        }
        .pickerStyle(.segmented)
    }
}

#Preview {
    HomeView()
}
