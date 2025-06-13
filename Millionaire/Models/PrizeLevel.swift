//
//  Untitled.swift
//  Millionaire
//
//  Created by Thanh Nhã on 13/6/25.
//

import Foundation

struct PrizeLevel: Identifiable, Codable {
    let id = UUID()
    let level: Int
    let prize: Int
    let isMilestone: Bool
}
