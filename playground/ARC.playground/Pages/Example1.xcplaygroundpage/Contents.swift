//: [Previous](@previous)

import Foundation

// Any: 모든 타입에 대해 대응 가능 (구조체, 열거형, 클래스, 클로저 등)
// => 런타임에서 타입 체크!!
// AnyObject: 모든 클래스 타입의 인스턴스만 담을 수 있음!! : TypeAlias
    // 클래스 제약을 설정할 수 있음 ㅋ 당연함!! 클래스만 사용 가능하니까~
    // 요 키워드만 붙어 있으면 클래스에서만 사용하는 게 명시적이니까 해당 프로토콜이 구조체 / enum 대응에 대한 준비를 안 하니까 더 효율적임
// 명시적으로 반환값이 없는 함수라고 해놓음!!
// () -> Void == () -> ()
// Void 역시 TypeAlias로 구성되어 있음

// 반환값이 없을 때는 명확하게 사용하는 편!!
func welcome() -> () {
    
}

//typealias man = false

let name = "고래밥"
let age = 10
//let gender = man
// 어떤 값을 설정하려고 했는지가 기억이 안 날 수도 있음.............
// Bool값이나 String값에 별칭 붙이기 가능함!!
let birth = Date()

//let arrayList: [Any] = [name, age, gender, birth]

// 런타임 시점에 타입이 결정되기 때문에, 런타임 오류가 발생할 수 있어 사용에 주의가 필요함!!
//arrayList[0]

// :3c


protocol Sample: AnyObject {
    func example()
}

class UserClass: Sample {
    func example() {
        
    }
}

//struct UserStruct: Sample {
//    func example() {
//
//    }
//}













//: [Next](@next)
