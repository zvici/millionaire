//
//  SpeechManager.swift
//  Millionaire
//
//  Created by Thanh Nhã on 15/6/25.
//

import AVFoundation

class SpeechManager {
    static let shared = SpeechManager()
    
    private let synthesizer = AVSpeechSynthesizer()
    
    func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "vi-VN") // giọng Việt
        utterance.rate = 0.45 // tốc độ đọc (0.0 - 1.0)
        utterance.pitchMultiplier = 1.0 // độ cao giọng

        synthesizer.speak(utterance)
    }
    
    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
    }
}
