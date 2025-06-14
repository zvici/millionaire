//
//  GameView.swift
//  Millionaire
//
//  Created by Thanh Nhã on 12/6/25.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel = GameViewModel()
    @State private var activeModal: ActiveModal?

    private var currentQuestion: Question {
        viewModel.questions[viewModel.currentQuestionIndex]
    }

    func checkAnswer(index: Int) {
        viewModel.checkAnswer(index: index)
    }

    func gameOver() {
        viewModel.restartGame()
    }

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                IconButton(icon: "hand.raised", iconSize: 26) {
                    self.gameOver()
                }
                Spacer()
                Text("Điểm: \(viewModel.score)$")
                    .padding(16)
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .glassEffect()
                Spacer()
                IconButton(icon: "slider.horizontal.3", iconSize: 26) {
                    activeModal = .gameInfo
                }
            }
            HStack(spacing: 20) {
                IconButton(
                    icon: "50.circle.fill",
                    iconSize: 40,
                    disabled: viewModel.hasUsedFiftyFifty
                ) {
                    viewModel.useFiftyFifty()
                }
                IconButton(
                    icon: "phone.fill",
                    iconSize: 30,
                    disabled: viewModel.hasUsedphoneAFriend
                ) {
                    viewModel.usePhoneAFriend()
                    activeModal = .phoneAFriend
                }
                IconButton(icon: "person.3.fill", iconSize: 20, disabled: true)
                {
                    print("People")
                }
            }
            .padding(.vertical, 30)
            ZStack(alignment: .topLeading) {
                VStack {
                    Text(currentQuestion.text)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .lineLimit(nil)
                        .multilineTextAlignment(.center)
                        .frame(minHeight: 150)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .glassEffect(.regular, in: .rect(cornerRadius: 20))

                Text("Câu \(viewModel.currentQuestionIndex + 1)")
                    .padding(16)
                    .glassEffect()
                    .offset(x: 0, y: -42)
                    .fontWeight(.bold)
            }
            .padding(.top, 40)
            .padding(.bottom, 20)
            VStack {
                ForEach(Array(currentQuestion.answers.enumerated()), id: \.0) {
                    index,
                    answer in
                    AnswerButton(
                        title:
                            "\(Character(UnicodeScalar(65 + index)!)): \(answer)",
                        dimmed: viewModel.fiftyFiftyIndices != nil
                            && !(viewModel.fiftyFiftyIndices!.contains(index))
                    ) {
                        self.checkAnswer(index: index)
                    }
                }
            }
            Spacer()
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("background").resizable().edgesIgnoringSafeArea(.all)
        )
        .navigationBarBackButtonHidden(true)
        .fullScreenCover(item: $activeModal) { modal in
            switch modal {
            case .gameInfo:
                GameInfoModal(
                    currentLevel: viewModel.currentQuestionIndex,
                    prizeLevels: viewModel.prizeLevels
                )
            case .phoneAFriend:
                PhoneAFriendModal(
                    currentQuestion: currentQuestion
                )
            case .askTheAudience:
                GameInfoModal(
                    currentLevel: viewModel.currentQuestionIndex,
                    prizeLevels: viewModel.prizeLevels
                )
            }
        }
    }
}

#Preview {
    GameView()
}
