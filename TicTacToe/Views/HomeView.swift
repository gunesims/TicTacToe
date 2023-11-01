//
//  HomeView.swift
//  TicTacToe
//
//  Created by Crossley Rozario on 10/30/23.
//  Copyright © 2023 Crossley Rozario. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                Text("Select Game Mode")
                    .font(.title)
                    .bold()
                
                NavigationLink {
                    GameView(gameMode: .ai)
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
                    GameView(gameMode: .friend)
                } label: {
                    Text("Friend")
                        .font(.largeTitle)
                        .frame(width: 200)
                        .foregroundStyle(.white)
                        .padding(5)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .fill(Color.button))
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
