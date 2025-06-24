//
//  DoubleBorderBackground.swift
//  Millionaire
//
//  Created by Thanh Nhã on 15/6/25.
//

import SwiftUI

struct DoubleBorderBackground: ViewModifier {
    var cornerRadius: CGFloat = 0
    func body(content: Content) -> some View {
        content
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(
                            LinearGradient(
                                colors: [AppColor.gold, AppColor.gold2],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 10
                        )
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(AppColor.background3)
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(AppColor.text, lineWidth: 1)
                        .padding(4)
                }
            )
    }
}
