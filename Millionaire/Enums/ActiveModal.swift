//
//  ActiveModal.swift
//  Millionaire
//
//  Created by Thanh Nhã on 12/6/25.
//

import Foundation

enum ActiveModal: Identifiable {
    case gameInfo
    case phoneAFriend
    case askTheAudience

    var id: String {
        switch self {
        case .gameInfo: return "gameInfo"
        case .phoneAFriend: return "phoneAFriend"
        case .askTheAudience: return "askTheAudience"
        }
    }
}
