//
//  GameSetupView.swift
//  TicTacToe
//
//  Created by Crossley Rozario on 11/24/23.
//  Copyright © 2023 Crossley Rozario. All rights reserved.
//

import SwiftUI

struct GameSetupView: View {
    var simpleGameMode: SimpleGameMode
    @State private var selectedSymbol = Symbol.x
    @State private var selectedAIDifficulty: AIGameMode = .easy

    var body: some View {
        VStack {
            HStack {
                Text("You")
                SymbolPicker(selectedSymbol: $selectedSymbol)
                    .frame(width: 200)
            }
            
            if simpleGameMode == .AI {
                HStack {
                    Text("AI")
                    AIDifficultyPicker(selectedDifficulty: $selectedAIDifficulty)
                        .frame(width: 200)
                }
            }
            
            NavigationLink {
                if simpleGameMode == .friend {
                    GameView(gameMode: .friend, selectedSymbol: selectedSymbol)
                } else if simpleGameMode == .AI {
                    if selectedAIDifficulty == .easy {
                        GameView(gameMode: .easyAI, selectedSymbol: selectedSymbol)
                    } else if selectedAIDifficulty == .medium {
                        GameView(gameMode: .mediumAI, selectedSymbol: selectedSymbol)
                    } else {
                        GameView(gameMode: .hardAI, selectedSymbol: selectedSymbol)
                    }
                }
            } label: {
                Text("Play")
                    .font(.largeTitle)
                    .frame(width: 200)
                    .foregroundStyle(.white)
                    .padding(5)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(Color.button))
            }
            
        }
        .onAppear {
            setup()
        }
        .onDisappear {
            saveAIGameMode()
        }
    }
    
    func setup() {
        if let aiDifficulty = retrieveAIGameMode() {
            selectedAIDifficulty = aiDifficulty
        }
    }
    
    func saveAIGameMode() {
        let key = "aiGameMode"
        UserDefaults.standard.set(selectedAIDifficulty.rawValue, forKey: key)
    }
    
    func retrieveAIGameMode() -> AIGameMode? {
        let key = "aiGameMode"
        if let rawValue = UserDefaults.standard.string(forKey: key), let value = AIGameMode(rawValue: rawValue) {
            return value
        }
        return nil
    }
}



struct AIDifficultyPicker: View {
    @Binding var selectedDifficulty: AIGameMode
    
    var body: some View {
        Picker("Difficulty", selection: $selectedDifficulty) {
            Text("Easy")
                .tag(AIGameMode.easy)
            Text("Medium")
                .tag(AIGameMode.medium)
            Text("Hard")
                .tag(AIGameMode.hard)
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
    GameSetupView(simpleGameMode: .AI)
}
