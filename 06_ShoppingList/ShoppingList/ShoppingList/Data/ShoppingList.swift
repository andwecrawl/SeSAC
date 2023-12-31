//
//  ShoppingList.swift
//  ShoppingList
//
//  Created by yeoni on 2023/07/28.
//

import Foundation

struct Shopping {
    var list: [Stuff] = [
    Stuff(name: "양말", liked: true, checked: false),
    Stuff(name: "트랙패드", liked: true, checked: true),
    Stuff(name: "찢청", liked: true, checked: false),
    Stuff(name: "브로콜리", liked: false, checked: false)
    ]
    
    func makeTag(stuff: Stuff) -> String {
        return stuff.name
    }
    
    func containedList(str: String) -> Bool {
        for element in list {
            if element.name == str {
                return true
            }
        }
        return false
    }
}
