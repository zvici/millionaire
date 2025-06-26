//
//  AskAudienceModal.swift
//  Millionaire
//
//  Created by Thanh Nhã on 24/6/25.
//

import Charts
import SwiftUI

struct AudienceVote: Identifiable {
    let id = UUID()
    let label: String  // A, B, C, D
    let percent: Int
}

struct AskAudienceModal: View {
    let currentQuestion: Question
    let fiftyFiftyIndices: [Int]?  // nil nếu chưa dùng 50/50

    @Environment(\.dismiss) var dismiss

    var voteResults: [AudienceVote] {
        let indices: [Int]
        if let fiftyFifty = fiftyFiftyIndices {
            indices = fiftyFifty.sorted()
        } else {
            indices = [0, 1, 2, 3]
        }

        let correctIndex = currentQuestion.correctIndex
        var values: [Int] = []

        for i in 0..<4 {
            if indices.contains(i) {
                values.append(
                    i == correctIndex
                        ? Int.random(in: 50...70) : Int.random(in: 10...30)
                )
            } else {
                values.append(0)
            }
        }

        let total = values.reduce(0, +)
        return indices.map { i in
            let label = String(UnicodeScalar(65 + i)!)
            let percent = Int(round(Double(values[i]) * 100.0 / Double(total)))
            return AudienceVote(label: label, percent: percent)
        }
    }

    @State private var revealedVotes: [AudienceVote] = []

    var body: some View {
        VStack(spacing: 20) {
            Text("Ý kiến khán giả trong trường quay")
                .font(.title2)
                .bold()
                .foregroundColor(AppColor.gold)

            Chart(revealedVotes) { vote in
                BarMark(
                    x: .value("Đáp án", vote.label),
                    y: .value("Tỷ lệ", vote.percent)
                )
                .foregroundStyle(AppColor.gold)
                .annotation(position: .bottom) {
                    VStack(spacing: 4) {
                        Text("\(vote.percent)%")
                            .font(.subheadline)
                            .foregroundColor(.white)
                        Text(vote.label)
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
            }
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            .frame(height: 300)
            .padding()
            Button("Đóng") {
                dismiss()
            }
            .foregroundStyle(.white)
            .padding(10)
            .modifier(DoubleBorderBackground(cornerRadius: 20))
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(
                colors: [AppColor.background3, .black],
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .onAppear {
            Task {
                for vote in voteResults {
                    try? await Task.sleep(nanoseconds: 1_000_000_000)  // 1 giây
                    withAnimation {
                        revealedVotes.append(vote)
                    }
                }
            }
        }
    }

}
