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
            .frame(width: 56, height: 56)
            .font(.system(size: iconSize))
            .glassEffect(.regular.interactive())
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
