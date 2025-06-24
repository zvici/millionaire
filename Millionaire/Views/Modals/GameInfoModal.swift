//
//  GameInfoModal.swift
//  Millionaire
//
//  Created by Thanh Nhã on 12/6/25.
//

import SwiftUI

struct GameInfoModal: View {
    @Environment(\.dismiss) var dismiss
    let currentLevel: Int
    let prizeLevels: [PrizeLevel]

    var body: some View {
        VStack {
            VStack {
                ForEach(prizeLevels) { level in
                    HStack {
                        Text("\(level.level)")
                            .foregroundStyle(.white)
                        Spacer()
                        Text("\(level.prize) $")
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                    }
                    .frame(width: 110)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 7)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(
                                Color.white.opacity(
                                    currentLevel + 1 == level.level ? 1 : 0
                                ),
                                lineWidth: 3
                            )
                    )
                    .modifier(DoubleBorderBackground(cornerRadius: 20))
                }
            }

            Button("Đóng") {
                dismiss()
            }
            .padding(.all)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(
                colors: [.blue.opacity(0.6), .black],
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}

#Preview {
    ContentView()
}
