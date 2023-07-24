//
//  CoinedWordsData.swift
//  NewlyCoinedWord
//
//  Created by yeoni on 2023/07/20.
//

import Foundation

let coinedWords: [String: String] = [
    "LAMESTREAM": "lame(변변찮은)과 mainstream(주, 메인)을 합친 말로, 이제는 그 가치가 떨어져 주를 이루던 매체나 미디어를 뜻하는 단어",
    "BAE": "“Before Anyone Else” 의 줄임말로 ‘애인’을 뜻함.",
    "BRAIN FADE": "집중하거나 깊은 생각을 할 수 없는 일시적인 뇌의 비활성화를 뜻하는 단어",
    "HOT MESS": "멋있지만 우스꽝스러운 행동을 하거나 실수를 남발하는 등의 행동을 하는 사람을 말함",
    "JANKY": "어떤 것이 믿음직스럽지 않고 품질이 안 좋을 때 사용함",
    "HANGRY": "Hungry와 Angry를 합친 말로, 배고파서 화가 난다는 뜻",
    "YAS": "You Are Stunning의 줄임말로, 너 정말 멋져! 라는 뜻",
    "SLAY": "무대를 장악하다, 찢었다라는 뜻으로 사용함",
    "UPPERWEAR": "화상 회의를 할 때 상의만 신경쓰는 것을 말함"
]

func randomWords() -> [String] {
    var wordsSet: Set<String> = []
    repeat {
        let randomWord = coinedWords.randomElement()!
        wordsSet.insert(randomWord.key)
    } while wordsSet.count < 4
    
    return Array(wordsSet)
}
