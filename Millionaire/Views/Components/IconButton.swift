//
//  IconButton.swift
//  Millionaire
//
//  Created by Thanh Nhã on 12/6/25.
//

import SwiftUI

struct IconButton: View {
    let icon: String
    let iconSize: CGFloat
    let disabled: Bool
    let action: () -> Void

    init(
        icon: String,
        iconSize: CGFloat,
        disabled: Bool = false,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.iconSize = iconSize
        self.disabled = disabled
        self.action = action
    }

    var body: some View {
        Image(systemName: icon)
            .font(.system(size: iconSize))
            .foregroundStyle(AppColor.text)
            .frame(width: 56, height: 56)
            .background(
                ZStack {
                    // Outer gradient border
                    Circle()
                        .stroke(
                            LinearGradient(
                                colors: [AppColor.gold, AppColor.gold2],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 6
                        )

                    // Background fill
                    Circle()
                        .fill(AppColor.background3)
                        .padding(3)  // Để nằm gọn trong viền ngoài

                    // Inner thin border
                    Circle()
                        .stroke(AppColor.text, lineWidth: 1)
                        .padding(4)  // Nằm trong viền ngoài một chút
                }
            )
            .opacity(disabled ? 0.3 : 1.0)
            .onTapGesture {
                if !disabled {
                    action()
                }
            }
    }
}

#Preview {
    ContentView()
}
