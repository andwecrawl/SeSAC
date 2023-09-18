//
//  SettingData.swift
//  PracticeDifffable
//
//  Created by yeoni on 2023/09/18.
//

import Foundation

struct Item: Hashable {
    let title: String?
    private let identifier = UUID()
}

let sectionTitle: [Item] = [
    Item(title: "전체 설정"),
    Item(title: "개인 설정"),
    Item(title: "기타")
]

let firstElement = [
    Item(title: "공지사항"),
    Item(title: "실험실"),
    Item(title: "버전 정보")
]

let secondElement = [
    Item(title: "개인/보안"),
    Item(title: "알림"),
    Item(title: "채팅"),
    Item(title: "멀티 프로필")
]

let thirdElement = [
    Item(title: "고객센터/도움말")
]
