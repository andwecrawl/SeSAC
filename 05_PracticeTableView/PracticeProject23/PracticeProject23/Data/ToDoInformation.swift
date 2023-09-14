//
//  ToDoInformation.swift
//  PracticeProject23
//
//  Created by yeoni on 2023/07/28.
//

import UIKit

struct TodoInformation {
    
    var list = [
        ToDo(main: "잠자기", sub: "23.07.03", like: true, done: false, color: TodoInformation.randomBackgroundColor()),
        ToDo(main: "글쓰기", sub: "23.07.30", like: true, done: true, color: TodoInformation.randomBackgroundColor()),
        ToDo(main: "밥먹기", sub: "23.07.16", like: false, done: true, color: TodoInformation.randomBackgroundColor()),
        ToDo(main: "약속잡기", sub: "23.07.28", like: true, done: false, color: TodoInformation.randomBackgroundColor())
    ]
    
    static func randomBackgroundColor() -> UIColor {
        
        let red = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)

        return UIColor(red: red, green: green, blue: blue, alpha: 1)
        
    }
}
