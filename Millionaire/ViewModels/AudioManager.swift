//
//  Untitled.swift
//  Millionaire
//
//  Created by Thanh Nhã on 15/6/25.
//

import Foundation
import AVFoundation

class AudioManager {
    static let shared = AudioManager()

    private var backgroundPlayer: AVAudioPlayer?

    func playBackgroundMusic() {
        guard let url = Bundle.main.url(forResource: "Q1_to_q5_bed", withExtension: "mp3") else {
            print("⚠️ Không tìm thấy file nhạc")
            return
        }

        do {
            backgroundPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundPlayer?.numberOfLoops = -1 // Lặp vô hạn
            backgroundPlayer?.volume = 0.5
            backgroundPlayer?.play()
        } catch {
            print("🚨 Lỗi phát nhạc: \(error.localizedDescription)")
        }
    }

    func stopBackgroundMusic() {
        backgroundPlayer?.stop()
    }
}
