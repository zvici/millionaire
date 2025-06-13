//
//  ActiveModal.swift
//  Millionaire
//
//  Created by Thanh Nhã on 12/6/25.
//

import Foundation

enum ActiveModal: Identifiable {
    case gameInfo
    case settings
    case about

    var id: String {
        switch self {
        case .gameInfo: return "gameInfo"
        case .settings: return "settings"
        case .about: return "about"
        }
    }
}
