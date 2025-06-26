//
//  AppColor.swift
//  Millionaire
//
//  Created by Thanh Nhã on 15/6/25.
//

import Foundation
import SwiftUI

struct AppColor {
    static let primary = Color(hex: "#1E90FF")
    static let secondary = Color(hex: "#FF9500")
    static let background = Color(hex: "#132225")
    static let background2 = Color(hex: "#0D1413")
    static let background3 = Color(hex: "#213F3C")
    static let danger = Color(hex: "#FF3B30")
    static let success = Color(hex: "#34C759")
    static let warning = Color(hex: "#FFD700")
    static let text = Color(hex: "#60C4AE")
    static let gold = Color(hex: "#F4CC85")
    static let gold2 = Color(hex: "#755622")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            .uppercased()
        let scanner = Scanner(string: hex)

        if hex.hasPrefix("#") {
            scanner.currentIndex = hex.index(after: hex.startIndex)
        }

        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = Double((rgbValue >> 16) & 0xFF) / 255
        let g = Double((rgbValue >> 8) & 0xFF) / 255
        let b = Double(rgbValue & 0xFF) / 255

        self.init(red: r, green: g, blue: b)
    }
}
