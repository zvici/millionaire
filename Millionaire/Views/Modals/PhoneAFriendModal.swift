//
//  PhoneAFriendModal.swift
//  Millionaire
//
//  Created by Thanh Nhã on 13/6/25.
//

import SwiftUI

struct Helper: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let avatar: String
}

struct ChatMessage: Identifiable, Hashable {
    let id = UUID()
    let sender: String // "Tôi" hoặc helper.name
    let content: String
}

struct PhoneAFriendModal: View {
    let currentQuestion: Question
    
    let helpers: [Helper] = [
        Helper(name: "Khá Bảnh", avatar: "friend1"),
        Helper(name: "Jack 97", avatar: "friend1"),
        Helper(name: "Ronaldo", avatar: "friend1"),
        Helper(name: "Jayce", avatar: "friend1"),
        Helper(name: "Bình", avatar: "friend1"),
        Helper(name: "Hà", avatar: "friend1")
    ]
    @State private var selectedHelper: Helper? = nil
    @State private var chatMessages: [ChatMessage] = []
    @State private var pendingMessages: [ChatMessage] = []
    @Environment(\.dismiss) var dismiss

    var body: some View {
        let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
        VStack(spacing: 24) {
            if selectedHelper != nil {
                VStack(alignment: .leading, spacing: 16) {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(chatMessages) { msg in
                                HStack {
                                    if msg.sender == "Tôi" { Spacer() }
                                    Text("\(msg.sender): \(msg.content)")
                                        .padding(10)
                                        .background(msg.sender == "Tôi" ? Color.blue.opacity(0.6) : Color.gray.opacity(0.5))
                                        .foregroundColor(.white)
                                        .cornerRadius(12)
                                    if msg.sender != "Tôi" { Spacer() }
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 340)
                Button("Đóng"){
                    dismiss()
                }
                .buttonStyle(.glass)
            } else {
                Text("Chọn người bạn muốn gọi")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(helpers) { helper in
                        Button(action: {
                            selectedHelper = helper
                            let messages = [
                                ChatMessage(sender: "Tôi", content: "Chào \(helper.name)!"),
                                ChatMessage(sender: helper.name, content: "Chào bạn! Có gì giúp được không?"),
                                ChatMessage(sender: "Tôi", content: "Đây là câu hỏi của mình: \(currentQuestion.text)"),
                                ChatMessage(sender: helper.name, content: "Theo mình đáp án đúng là ..."),
                            ]
                            chatMessages = []
                            pendingMessages = messages
                            Task {
                                await showNextMessage()
                            }
                        }) {
                            VStack {
                                Image(helper.avatar)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: .infinity, height: 100)
                                Text(helper.name)
                                    .foregroundColor(.white)
                                    .font(.headline)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 300)
                            .glassEffect(.regular, in: .rect(cornerRadius: 20))
                        }
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(
                colors: [.blue.opacity(0.6), .black],
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }

    private func showNextMessage() async {
        while !pendingMessages.isEmpty {
            try? await Task.sleep(nanoseconds: 1000_000_000)
            chatMessages.append(pendingMessages.removeFirst())
        }
    }
}

#Preview {
    ContentView()
}
