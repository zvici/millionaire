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
    let action: () -> Void
    var body: some View {
        Image(systemName: icon)
            .frame(width: 56, height: 56)
            .font(.system(size: iconSize))
            .glassEffect(.regular.interactive())
            .onTapGesture {
                action()
            }
    }
}

#Preview {
    ContentView()
}
