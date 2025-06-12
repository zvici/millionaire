//
//  GameViewModel.swift
//  Millionaire
//
//  Created by Thanh Nhã on 12/6/25.
//

import Foundation
import Combine

class GameViewModel: ObservableObject {
    @Published var questions: [Question] = []
    @Published var currentQuestionIndex: Int = 0
    @Published var score: Int = 0
    @Published var isAnswerCorrect: Bool? = nil
    @Published var isGameOver: Bool = false
    
    init() {
        fetchQuestions()
    }

    func fetchQuestions() {
        self.questions = [
            Question(
                text: "Điền vào câu thành ngữ sau: Đàn gảy ... trâu?",
                answers: ["Chân", "Mắt", "Tai", "Mũi"],
                correctIndex: 2
            ),
            Question(
                text: "Thủ đô Pháp?",
                answers: ["London", "Paris", "Berlin", "Rome"],
                correctIndex: 1
            ),
        ]
    }
    
    func checkAnswer(index: Int){
        isAnswerCorrect = questions[currentQuestionIndex].correctIndex == index
        print("answer \(isAnswerCorrect ?? false)")
        if isAnswerCorrect == true {
            score += 10
            nextQuestion()
        }
    }
    
    func nextQuestion() {
        isAnswerCorrect = nil
        if(currentQuestionIndex + 1 < questions.count){
            currentQuestionIndex += 1
        } else {
            isGameOver = true
        }
    }
    
    func restartGame() {
        currentQuestionIndex = 0
        score = 0
        isGameOver = false
        fetchQuestions()
    }
}

