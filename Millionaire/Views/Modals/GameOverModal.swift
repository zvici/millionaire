//
//  GameOverModal.swift
//  Millionaire
//
//  Created by Thanh Nhã on 26/6/25.
//

import SwiftUI

struct GameOverModal: View {
    var score: Int
    var onDismiss: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Kết thúc trò chơi!")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(AppColor.gold)
            Text("\(score) 💰")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundStyle(.yellow)
                .padding(.bottom)
            Button("Kết thúc") {
                onDismiss()
            }
            .padding()
            .frame(width: 200)
            .foregroundStyle(.white)
            .fontWeight(.bold)
            .cornerRadius(12)
            .modifier(DoubleBorderBackground())
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            AppColor.background
        )
    }
}

