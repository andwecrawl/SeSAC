//
//  Setting.swift
//  PracticeDifffable
//
//  Created by yeoni on 2023/09/18.
//

import Foundation

struct ModeSetting: Hashable {
    let id = UUID().uuidString
    let title: String
    let subtitle: String
    let secondaryText: String
    let image: String
}
