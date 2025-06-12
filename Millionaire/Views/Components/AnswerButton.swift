//
//  AnswerButton.swift
//  Millionaire
//
//  Created by Thanh Nhã on 12/6/25.
//

import SwiftUI

struct AnswerButton: View {
    let title: String
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
                .frame(height: 40)
                .cornerRadius(16)

        }
        .buttonStyle(.glass)
    }
}

#Preview {
    ContentView()
}
