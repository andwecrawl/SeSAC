//: [Previous](@previous)

import Foundation
//
//print("hello")
//
//// main - serial - async
//
//// 닭벼슬한테 너 다른 작업 먼저 해!! 하고 일 시키자
//DispatchQueue.main.async {
//    for i in 1...100 {
//        print(i, terminator: " ")
//    }
//}
//
//for i in 101...200 {
//    print(i, terminator: " ")
//}
//
//print("goodbye")

// main일 때는 일을 나중으로 미루는 거임!!



print("hello")

// 오잉? 크게 차이가 없음......
// main sync!!
// 자기가 맡은 일들을 끝날 때까지 기다리고 있음
// 10초 동안 일하고 5초 동안 또 다른 일 하고 7초 동안 또 다른 일을......

// 동기로 다른 알바생한테 일 시키는 거임
// 다른 알바생한테 새 일들을 보내고 아무것도 일을 하지 못하고 동기로 일을 다 한 이후에 일을 맡길 수 있는 상태가 나옴
// => global().sync (내 일 다 끝날 때까지!! 일하면 안 대?) // 닭이 혼자 일하는 거랑 똑가틈
// 닭벼슬이 혼자 일하는 사람이면 혼자 메인에서 작업하게 ㄷ

for i in 1...100 {
    DispatchQueue.global().async {
        print(i, terminator: " ")
    }
}

for i in 101...200 {
    print(i, terminator: " ")
}


print("goodbye")






/*
 닭 1 2 3 4 5 6 7 8
 3456 => 매니저한테 가서 두고 있깅
 그 이후 여러 알바생들한테 골고루 분배하는 게.. .........
 닭의 와중에는 1번부터 200번까지 우다다 실행되는 거임
 1. 여기서는 더 빠리 작업이 끝남
 2. 하지만 누가 먼저 언제 끝날지 명확히 모른다.
 
 
 메인에서 동작 -> 동기?   ㅏㄴㄷㄷ
 
 */









//: [Next](@next)
