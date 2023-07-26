//
//  EmoteData.swift
//  EmoteDiary
//
//  Created by yeoni on 2023/07/25.
//

import Foundation

enum Emote: Int, CaseIterable {
    case happy
    case good
    case soso
    case notBad
    case bad
    
    var tag: String {
        switch self {
        case .happy:
            return "happy"
        case .good:
            return "good"
        case .soso:
            return "soso"
        case .notBad:
            return "notBad"
        case .bad:
            return "bad"
        }
    }
    
}

var emoteValue: [String: Int] = [
    "happy": 0,
    "good": 0,
    "soso": 0,
    "notBad": 0,
    "bad": 0
]
