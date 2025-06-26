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
                Spacer()
                NavigationLink(destination: GameView()) {
                    Label("Bắt đầu", systemImage: "play.fill")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 200, height: 48)
                }
                .modifier(DoubleBorderBackground())
                Button(action: {}) {
                    Label("Điểm cao", systemImage: "star.fill")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 200, height: 48)
                }
                .modifier(DoubleBorderBackground())
                Spacer()

            }
            .padding(40)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("background"))
        }
    }
}

#Preview {
    ContentView()
}
