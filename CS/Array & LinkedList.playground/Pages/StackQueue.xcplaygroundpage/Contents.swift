//: [Previous](@previous)

import UIKit

//func isVPS(str: String) -> Bool {
//    var array = []
//
//    for element in str {
//        if !array.isEmpty {
//            let last = array.last
//            if last == "(" {
//                element == ")"
//                array.popLast()
//            }
//        }
//        array.append(element)
//    }
//}

extension Date {
    func compareNow() -> ComparisonResult {
        let date = Date()
        print(date)
        return self.compare(date)
    }
}

let now = Date()

print("now: \(now)")

print(now.compareNow().rawValue)

//: [Next](@next)
