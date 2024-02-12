//: [Previous](@previous)

import UIKit

var greeting = "Hello, playground"

// subscript
//greeting.index(startIndex, offsetBy: 2) // 런타임 오류!!
// String Struct에서는 subscript 구현이 안 되어 있기 때문!!
// 따라서, 익스텐션을 통해서 서브스크립트 구현을 하면 쓸 수 있음


extension String {
    
    // 배열에서 인덱스 가져올 때~~!
    subscript(idx: Int) -> String? {
        
        guard (0..<count).contains(idx) else {
            return nil
        }
        
        let result = index(startIndex, offsetBy: idx)
        return String(self[result])
    }
}

// subscript 안전 접근!!
// 이런 식으로 구현해서 런타임 오류가 발생하지 않도록 할 수도 있더라~
extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

let gg = [ 1, 2, 3, 4 ]

gg[safe: 10]


//: [Next](@next)
