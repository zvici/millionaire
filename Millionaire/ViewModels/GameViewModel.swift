//
//  GameViewModel.swift
//  Millionaire
//
//  Created by Thanh Nhã on 12/6/25.
//

import Combine
import Foundation

class GameViewModel: ObservableObject {
    // MARK: - Game State
    @Published var questions: [Question] = []
    @Published var currentQuestionIndex: Int = 0
    @Published var score: Int = 0
    @Published var prizeLevels: [PrizeLevel] = []
    @Published var isGameOver: Bool = false

    // MARK: - Answer State
    @Published var currentAnswerIndex: Int? = nil
    @Published var currentCorrectAnswerIndex: Int? = nil
    @Published var isAnswerCorrect: Bool? = nil
    @Published var answerStatus: AnswerStatus? = nil

    // MARK: - Lifelines
    @Published var fiftyFiftyIndices: [Int]? = nil
    @Published var hasUsedFiftyFifty: Bool = false
    @Published var hasUsedphoneAFriend: Bool = false
    @Published var hasUsedAskAudience: Bool = false

    // MARK: - Initialization
    init() {
        fetchQuestions()
        fetchPrizeLevels()
    }

    // MARK: - Main Game Logic

    /// Handles answer selection and determines correctness.
    func checkAnswer(index: Int) async {
        // Highlight the selected answer in yellow
        currentAnswerIndex = index
        answerStatus = .selected
        try? await Task.sleep(nanoseconds: 2_000_000_000)

        // Check if selected answer is correct
        let correct = questions[currentQuestionIndex].correctIndex
        isAnswerCorrect = (index == correct)
        currentCorrectAnswerIndex = correct
        answerStatus = isAnswerCorrect! ? .correct : .wrong
        AudioManager.shared.playSoundEffect((index == correct) ? "correct" : "wrong")
        try? await Task.sleep(nanoseconds: 2_000_000_000)

        if isAnswerCorrect == true {
            // Update score if answer is correct
            let level = currentQuestionIndex + 1
            if let prize = prizeLevels.first(where: { $0.level == level }) {
                score = prize.prize
            }
            try? await Task.sleep(nanoseconds: 500_000_000)
            nextQuestion()
        } else {
            // Restart game after wrong answer
            try? await Task.sleep(nanoseconds: 500_000_000)
            gameOver()
        }
    }

    /// Moves to the next question or ends game.
    func nextQuestion() {
        if currentQuestionIndex + 1 < questions.count {
            currentQuestionIndex += 1
            resetAnswerState()
        } else {
            isGameOver = true
        }
    }

    /// Game over
    func gameOver() {
       isGameOver = true
    }

    /// Clears current answer and selection state.
    private func resetAnswerState() {
        currentAnswerIndex = nil
        currentCorrectAnswerIndex = nil
        isAnswerCorrect = nil
        answerStatus = nil
        fiftyFiftyIndices = nil
    }

    // Reset game
    func resetGame() {
        currentQuestionIndex = 0
        isGameOver = false
        resetAnswerState()
        hasUsedFiftyFifty = false
        hasUsedphoneAFriend = false
        hasUsedAskAudience = false
    }
    
    // MARK: - Lifeline Logic

    /// Uses the 50:50 lifeline to eliminate two wrong answers.
    func useFiftyFifty() {
        let correctIndex = questions[currentQuestionIndex].correctIndex
        let indices = [0, 1, 2, 3].filter { $0 != correctIndex }.shuffled()
        fiftyFiftyIndices = [correctIndex, indices.first!]
        hasUsedFiftyFifty = true
    }

    /// Marks the "Phone a Friend" lifeline as used.
    func usePhoneAFriend() {
        hasUsedphoneAFriend = true
    }

    /// Marks the "Ask the Audience" lifeline as used.
    func useAskAudience() {
        hasUsedAskAudience = true
    }

    // MARK: - Data Loading

    /// Loads and filters 5 easy, 5 medium, and 5 hard questions.
    func fetchQuestions() {
        self.questions = loadJSON([Question].self, from: "questions")?
            .reduce(into: [Question]()) { result, question in
                if question.level == 1 && result.filter({ $0.level == 1 }).count < 5 {
                    result.append(question)
                } else if question.level == 2 && result.filter({ $0.level == 2 }).count < 5 {
                    result.append(question)
                } else if question.level == 3 && result.filter({ $0.level == 3 }).count < 5 {
                    result.append(question)
                }
            } ?? []
    }

    /// Loads prize levels from local JSON.
    func fetchPrizeLevels() {
        self.prizeLevels = loadJSON([PrizeLevel].self, from: "prize_levels") ?? []
    }

    // MARK: - JSON Helper

    /// Loads a JSON file and decodes it into the specified type.
    private func loadJSON<T: Decodable>(_ type: T.Type, from fileName: String) -> T? {
        guard
            let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let decoded = try? JSONDecoder().decode(T.self, from: data)
        else {
            print("⚠️ Failed to load \(fileName).json")
            return nil
        }
        return decoded
    }
}
