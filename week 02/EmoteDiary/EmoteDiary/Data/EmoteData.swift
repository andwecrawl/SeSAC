//
//  EmoteData.swift
//  EmoteDiary
//
//  Created by yeoni on 2023/07/25.
//

import Foundation

enum Emote: String, CaseIterable {
    case happy
    case good
    case soso
    case notBad
    case bad
}

let emoteArr = Emote.allCases

var emoteValue: [String: Int] = [
    "happy": 0,
    "good": 0,
    "soso": 0,
    "notBad": 0,
    "bad": 0
]
