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
    let backgroundColor: Color
    let action: () -> Void
    
    init(
        title: String,
        dimmed: Bool,
        backgroundColor: Color = AppColor.background3,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.dimmed = dimmed
        self.backgroundColor = backgroundColor
        self.action = action
    }


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
                    .fill(backgroundColor)
                    .animation(.easeInOut(duration: 0.3), value: backgroundColor)
            }
        )
        .opacity(dimmed ? 0.1 : 1.0)
        .disabled(dimmed)
    }
}

#Preview {
    ContentView()
}
