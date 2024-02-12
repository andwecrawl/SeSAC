//: [Previous](@previous)

import UIKit

// COW: Copy On Write
// 최적화에 대한 이야기임
// 메모리는 적게 잡아먹어야 하고 독립적으로 움직여야 한다.

func address(of object: UnsafeRawPointer) -> String {
    let address = Int(bitPattern: object)
    return String(format: "%p", address)
}

var nickname = "빈이름"

address(of: &nickname)

var newNickname = nickname

address(of: &newNickname)

var newNickname2 = nickname

address(of: &newNickname2)

var newNickname3 = nickname

address(of: &newNickname3)

// 이 새로운 변수들이 많아지면 어차피 같은 내용인데 모두 각각의 메모리를 차지하고 있는 건 비효율적임!!
// 그럼 어떻게 최적화를 할 수 있을까?
// 변경이 안 될 요소들에 대해서는 실질적으로 공간을 차지하는 건 정해져 있으니 닉네임을 복사할 때 실제로 데이터를 복사하는 게 아니라 그 주솟값만 복사 후 가리키는 걸 말함


var array = Array(repeating: "yeoni", count: 100)

address(of: array)

var newArray = array

address(of: newArray)

// 값을 변경하지 않는다면 원본 메모리를 공유함!!
// 값을 추가 / 삭제 / 수정하게 된다면 원본 데이터를 공유하는 게 아니라 값을 복사한 이후 업데이트하게 됨
newArray.append("hello")

address(of: newArray)


// COW => CollectionType에서 복사가 이루어질 때를 생각하면 댈 것 같음
// 여러 데이터를 저장하는 방식 자체가 CollectionType 자체에 많이 사용된다고 보면 댐
// CollectionType: Array, Dictionay, Set
    // String은 구조체이기 때문에 CollectionType에 들어가는 element 역할을 하는 거임 (요소)


//: [Next](@next)
