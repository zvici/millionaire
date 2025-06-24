//
//  GameViewModel.swift
//  Millionaire
//
//  Created by Thanh Nhã on 12/6/25.
//

import Combine
import Foundation

class GameViewModel: ObservableObject {
    @Published var questions: [Question] = []
    @Published var currentQuestionIndex: Int = 0
    @Published var isAnswerCorrect: Bool? = nil
    @Published var isGameOver: Bool = false
    @Published var prizeLevels: [PrizeLevel] = []
    @Published var score: Int = 0
    @Published var hasUsedFiftyFifty: Bool = false
    @Published var fiftyFiftyIndices: [Int]? = nil
    @Published var hasUsedphoneAFriend: Bool = false
    @Published var hasUsedAskAudience: Bool = false

    init() {
        fetchQuestions()
        fetchPrizeLevels()
    }

    func fetchQuestions() {
        guard
            let url = Bundle.main.url(
                forResource: "questions",
                withExtension: "json"
            ),
            let data = try? Data(contentsOf: url),
            let loadedQuestions = try? JSONDecoder().decode(
                [Question].self,
                from: data
            )
        else {
            print("⚠️ Can't load questions from JSON")
            return
        }
        self.questions = Array(loadedQuestions.shuffled().prefix(15))
    }

    func fetchPrizeLevels() {
        guard
            let url = Bundle.main.url(
                forResource: "prize_levels",
                withExtension: "json"
            ),
            let data = try? Data(contentsOf: url),
            let loadedPrizeLevels = try? JSONDecoder().decode(
                [PrizeLevel].self,
                from: data
            )
        else {
            print("⚠️ Can't load prize levels from JSON")
            return
        }
        self.prizeLevels = loadedPrizeLevels
    }

    func checkAnswer(index: Int) {
        isAnswerCorrect = questions[currentQuestionIndex].correctIndex == index
        if isAnswerCorrect == true {
            let level = currentQuestionIndex + 1
            if let prize = prizeLevels.first(where: { $0.level == level }) {
                score = prize.prize
            }
            nextQuestion()
        }
    }

    func nextQuestion() {
        isAnswerCorrect = nil
        fiftyFiftyIndices = nil
        if currentQuestionIndex + 1 < questions.count {
            currentQuestionIndex += 1
        } else {
            isGameOver = true
        }
        
    }

    func restartGame() {
        currentQuestionIndex = 0
        isGameOver = false
        score = 0
        fetchQuestions()
    }

    func useFiftyFifty() {
        let correctIndex = questions[currentQuestionIndex].correctIndex
        var indices = [0, 1, 2, 3].filter { $0 != correctIndex }
        indices.shuffle()
        let remainingWrongIndex = indices.first!
        fiftyFiftyIndices = [correctIndex, remainingWrongIndex]
        hasUsedFiftyFifty = true
    }
    
    func usePhoneAFriend() {
        hasUsedphoneAFriend = true
    }
    
    func useAskAudience() {
        hasUsedAskAudience = true
    }
}
