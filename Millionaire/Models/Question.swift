//
//  Question.swift
//  Millionaire
//
//  Created by Thanh Nhã on 12/6/25.
//

import Foundation

struct Question: Identifiable {
    let id = UUID()
    let text: String
    let answers: [String]
    let correctIndex: Int
}
