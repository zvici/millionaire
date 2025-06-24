//
//  AnswerButton.swift
//  Millionaire
//
//  Created by Thanh Nhã on 12/6/25.
//

import SwiftUI

struct AnswerButton: View {
    let title: String
    let dimmed: Bool
    let action: () -> Void

    var body: some View {
        Button(action: {
            if !dimmed {
                action()
            }
        }) {
            Text(title)
                .font(.system(size: 20))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
                .frame(height: 48)
        }
        .background(
            ZStack {
                Rectangle()
                    .stroke(
                        LinearGradient(
                            colors: [AppColor.gold, AppColor.gold2],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 5
                    )
                Rectangle()
                    .fill(AppColor.background3)
            }
        )
        .opacity(dimmed ? 0.1 : 1.0)
        .disabled(dimmed)
    }
}

#Preview {
    ContentView()
}
