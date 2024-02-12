//: [Previous](@previous)

import Foundation

func find(_ arr: [Int]) -> Bool {
    for index in arr.indices {
        if index == arr.count - 1 {
            return false
        }
        let otherIndex = index+1
        for otherIndex in otherIndex...arr.count-1 {
            if arr[index] + arr[otherIndex] == 101 {
                return true
            }
        }
    }
    return false
}

func find2(_ arr: [Int]) -> Bool {
    // Void Type은 메모리를 먹지 않음
        // Void == empty Tuple(ValueType)
        // 키값을 사용하지 않을 때는 Void로 선언하는 게 메모리적으로 가장 좋음
    // Bool: Swift 연산에서는 1byte를 저장함 ...
    var arrDic: [Int: Void] = [:]
    
    for value in arr {
        arrDic[value] = ()
    }
    
    for value in arr {
        if let _ = arrDic[101 - value] {
            return true
        }
    }
    
    return false
}

//find(arr: [1, 100, 0])
//find(arr: [42, 1, 30, 5, 8])
//find(arr: [30, 42, 1, 0, 11])


//: [Next](@next)
