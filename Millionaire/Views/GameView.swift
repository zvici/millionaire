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
                HStack {
                    Image(systemName: "dollarsign.circle.fill")
                        .font(.system(size: 22))
                        .foregroundStyle(AppColor.gold)
                    Text("\(viewModel.score)")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .lineLimit(nil)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                }
                .padding(14)
                .modifier(DoubleBorderBackground(cornerRadius: 30))
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
                IconButton(
                    icon: "person.3.fill",
                    iconSize: 20,
                    disabled: viewModel.hasUsedAskAudience
                ) {
                    viewModel.useAskAudience()
                    activeModal = .askTheAudience
                }
            }
            .padding(.vertical, 30)
            ZStack(alignment: .top) {
                VStack {
                    Text(currentQuestion.text)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .lineLimit(nil)
                        .multilineTextAlignment(.center)
                        .frame(minHeight: 150)
                        .foregroundStyle(.white)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .modifier(DoubleBorderBackground())
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
                                        colors: [
                                            AppColor.gold, AppColor.gold2,
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 10
                                )
                            Circle()
                                .fill(AppColor.background3)
                            Circle()
                                .stroke(AppColor.text, lineWidth: 1)
                                .padding(2)
                        }
                    )
                    .offset(y: -30)
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
        .background(Image("background"))
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
                AskAudienceModal(
                    currentQuestion: currentQuestion,
                    fiftyFiftyIndices: viewModel.fiftyFiftyIndices
                )
            }
        }
        .onAppear {
            AudioManager.shared.playBackgroundMusic()
        }
        .onDisappear {
            AudioManager.shared.stopBackgroundMusic()
        }
    }
}

#Preview {
    GameView()
}
