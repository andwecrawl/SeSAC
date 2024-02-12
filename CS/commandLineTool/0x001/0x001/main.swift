//
//  main.swift
//  0x001
//
//  Created by yeoni on 2023/10/12.
//

import Foundation


// #Mark
// Stack
struct Stack<T> {
    var elements: [T] = []
    init() { }
    
    mutating func push(element: T) {
        elements.append(element)
    }
    
    @discardableResult
    mutating func pop() {
        elements.popLast()
    }
}

let t = Int(readLine()!)!
var lines: [String] = []

for _ in 1...t {
    let line = readLine()!
    lines.append(line)
}

for line in lines {
    check(line) ? print("YES") : print("NO")
}


func check(_ line: String) -> Bool {
    var s = Stack<String>()
    for element in line {
        if element == "(" {
            s.push(element: String(element))
        } else {
            if s.elements.isEmpty {
                return false
            } else {
                s.pop()
            }
        }
    }
    return s.elements.isEmpty ? true : false
}

func isVPS(str: String) -> Bool {
    var array: [String] = []
    
    for element in str {
        if !array.isEmpty {
            let last = array.last
            if last == "(" {
                if element == ")" {
                    _ = array.popLast()
                }
            }
        }
        array.append(String(element))
    }
    
    return array.isEmpty
}




//let input = readLine()!.components(separatedBy: " ").map { Int($0)! }
//let a = input[0]
//let b = input[1]
//print(a+b)



//let inputA = readLine()!
//let inputB = readLine()!
//
//let numA = Int(inputA) ?? 0
//let numB = Int(inputB) ?? 0
//
//print("\(numA + numB)")
