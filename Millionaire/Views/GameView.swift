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
    @Environment(\.dismiss) private var dismiss

    // MARK: - Computed Properties

    private var currentQuestion: Question {
        viewModel.questions[viewModel.currentQuestionIndex]
    }

    // MARK: - Answer Logic

    private func checkAnswer(index: Int) {
        Task {
            await viewModel.checkAnswer(index: index)
        }
    }

    private func gameOver() {
        viewModel.gameOver()
    }

    private func colorForAnswer(_ index: Int) -> Color {
        guard let selected = viewModel.currentAnswerIndex,
              let status = viewModel.answerStatus else {
            return AppColor.background3
        }

        switch status {
        case .selected:
            return index == selected ? AppColor.warning : AppColor.background3
        case .correct:
            return index == selected ? AppColor.success : AppColor.background3
        case .wrong:
            if index == selected {
                return .red
            } else if index == viewModel.currentCorrectAnswerIndex {
                return AppColor.success
            } else {
                return AppColor.background3
            }
        }
    }

    // MARK: - Main View

    var body: some View {
        VStack(spacing: 16) {
            topBar
            lifelineButtons
            questionCard
            answerButtons
            Spacer()
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Image("background"))
        .navigationBarBackButtonHidden(true)
        .fullScreenCover(item: $activeModal, content: modalView)
        .onAppear {
             AudioManager.shared.playBackgroundMusic()
        }
        .onDisappear {
             AudioManager.shared.stopBackgroundMusic()
        }
        .allowsHitTesting(viewModel.currentAnswerIndex == nil)
        .fullScreenCover(isPresented: $viewModel.isGameOver) {
            GameOverModal(score: viewModel.score) {
                viewModel.resetGame()
                dismiss() // Quay về StartView
            }
        }
    }

    // MARK: - Subviews

    private var topBar: some View {
        HStack {
            IconButton(icon: "hand.raised", iconSize: 26) {
                gameOver()
            }
            Spacer()
            scoreView
            Spacer()
            IconButton(icon: "slider.horizontal.3", iconSize: 26) {
                activeModal = .gameInfo
            }
        }
    }

    private var scoreView: some View {
        HStack {
            Image(systemName: "dollarsign.circle.fill")
                .font(.system(size: 22))
                .foregroundStyle(AppColor.gold)
            Text("\(viewModel.score)")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundStyle(.white)
        }
        .padding(14)
        .modifier(DoubleBorderBackground(cornerRadius: 30))
    }

    private var lifelineButtons: some View {
        HStack(spacing: 20) {
            IconButton(icon: "50.circle.fill", iconSize: 40, disabled: viewModel.hasUsedFiftyFifty) {
                viewModel.useFiftyFifty()
            }
            IconButton(icon: "phone.fill", iconSize: 30, disabled: viewModel.hasUsedphoneAFriend) {
                viewModel.usePhoneAFriend()
                activeModal = .phoneAFriend
            }
            IconButton(icon: "person.3.fill", iconSize: 20, disabled: viewModel.hasUsedAskAudience) {
                viewModel.useAskAudience()
                activeModal = .askTheAudience
            }
        }
        .padding(.vertical, 30)
    }

    private var questionCard: some View {
        ZStack(alignment: .top) {
            VStack {
                Text(currentQuestion.text)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .frame(minHeight: 150)
                    .foregroundStyle(.white)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .modifier(DoubleBorderBackground())

            questionNumberCircle
                .offset(y: -30)
        }
        .padding(.top, 40)
        .padding(.bottom, 20)
    }

    private var questionNumberCircle: some View {
        Text("\(viewModel.currentQuestionIndex + 1)")
            .font(.system(size: 18))
            .fontWeight(.black)
            .foregroundStyle(.white)
            .frame(width: 56, height: 56)
            .background(
                ZStack {
                    Circle()
                        .stroke(
                            LinearGradient(
                                colors: [AppColor.gold, AppColor.gold2],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 10
                        )
                    Circle().fill(AppColor.background3)
                    Circle()
                        .stroke(AppColor.text, lineWidth: 1)
                        .padding(2)
                }
            )
    }

    private var answerButtons: some View {
        VStack {
            ForEach(Array(currentQuestion.answers.enumerated()), id: \.0) { index, answer in
                AnswerButton(
                    title: "\(Character(UnicodeScalar(65 + index)!)): \(answer)",
                    dimmed: viewModel.fiftyFiftyIndices?.contains(index) == false,
                    backgroundColor: colorForAnswer(index)
                ) {
                    checkAnswer(index: index)
                }
            }
        }
    }

    // MARK: - Modal View

    @ViewBuilder
    private func modalView(_ modal: ActiveModal) -> some View {
        switch modal {
        case .gameInfo:
            GameInfoModal(
                currentLevel: viewModel.currentQuestionIndex,
                prizeLevels: viewModel.prizeLevels
            )
        case .phoneAFriend:
            PhoneAFriendModal(currentQuestion: currentQuestion)
        case .askTheAudience:
            AskAudienceModal(
                currentQuestion: currentQuestion,
                fiftyFiftyIndices: viewModel.fiftyFiftyIndices
            )
        }
    }
}

#Preview {
    GameView()
}
