//
//  TicTacToeApp.swift
//  TicTacToe
//
//  Created by Crossley Rozario on 6/25/23.
//  Copyright © 2023 Crossley Rozario. All rights reserved.
//


import SwiftUI

@main
struct TicTacToeApp: App {
    @StateObject var ticTacToeGame = TicTacToeGame()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ticTacToeGame)
        }
    }
}

