//
//  StartView.swift
//  Millionaire
//
//  Created by Thanh Nhã on 12/6/25.
//

import SwiftUI

struct StartView: View {
    @StateObject var viewModel = GameViewModel()
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                Image("banner")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .glassEffect()
                Spacer()
                NavigationLink(destination: GameView()) {
                    Label("Start Game", systemImage: "play.fill")
                        .font(.system(size: 20))
                        .frame(width: 200, height: 40)
                }
                .buttonStyle(.glass)
                Button(action: {}) {
                    Label("High Score", systemImage: "star.fill")
                        .font(.system(size: 20))
                        .frame(width: 200, height: 40)
                }
                .buttonStyle(.glass)
                Spacer()

            }
            .padding(40)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image("background").resizable().edgesIgnoringSafeArea(.all)
            )
        }
    }
}

#Preview {
    ContentView()
}
