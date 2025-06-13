//
//  GameInfoModal.swift
//  Millionaire
//
//  Created by Thanh Nhã on 12/6/25.
//

import SwiftUI

struct PrizeLevel: Identifiable {
    let id = UUID()
    let level: Int
    let prize: String
    let isMilestone: Bool
}

struct GameInfoModal: View {
    @Environment(\.dismiss) var dismiss
    let currentLevel: Int = 3

    let prizeLevels: [PrizeLevel] = [
        PrizeLevel(
            level: 15,
            prize: "150.000",
            isMilestone: true,
        ),
        PrizeLevel(
            level: 14,
            prize: "85.000",
            isMilestone: false,
        ),
        PrizeLevel(
            level: 13,
            prize: "60.000",
            isMilestone: false,
        ),
        PrizeLevel(
            level: 12,
            prize: "40.000",
            isMilestone: false,
        ),
        PrizeLevel(
            level: 11,
            prize: "30.000",
            isMilestone: false,
        ),
        PrizeLevel(
            level: 10,
            prize: "22.000",
            isMilestone: true,
        ),
        PrizeLevel(
            level: 9,
            prize: "14.000",
            isMilestone: false,
        ),
        PrizeLevel(
            level: 8,
            prize: "10.000",
            isMilestone: false,
        ),
        PrizeLevel(
            level: 7,
            prize: "6.000",
            isMilestone: false,
        ),
        PrizeLevel(
            level: 6,
            prize: "3.000",
            isMilestone: false,
        ),
        PrizeLevel(
            level: 5,
            prize: "2.000",
            isMilestone: true,
        ),
        PrizeLevel(
            level: 4,
            prize: "1.000",
            isMilestone: false,
        ),
        PrizeLevel(
            level: 3,
            prize: "600",
            isMilestone: false,
        ),
        PrizeLevel(
            level: 2,
            prize: "400",
            isMilestone: false,
        ),
        PrizeLevel(
            level: 1,
            prize: "200",
            isMilestone: false,
        ),
    ]

    var body: some View {
        VStack {
            VStack {
                ForEach(prizeLevels) { level in
                    HStack {
                        Text("\(level.level)")
                        Spacer()
                        Text("\(level.prize) $")
                            .fontWeight(.bold)
                    }
                    .frame(width: 110)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 7)
                    .glassEffect(
                        level.isMilestone
                            ? .regular.tint(.orange.opacity(0.5)) : .regular
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(
                                Color.white.opacity(
                                    currentLevel == level.level ? 1 : 0
                                ),
                                lineWidth: 3
                            )
                    )
                }
            }

            Button("Đóng") {
                dismiss()
            }
            .padding(.all)
            .buttonStyle(.glass)
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
    GameInfoModal()
}
