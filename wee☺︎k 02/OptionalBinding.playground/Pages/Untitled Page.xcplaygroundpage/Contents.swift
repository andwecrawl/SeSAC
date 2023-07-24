import UIKit

var nickname: String?
var age: Int?

print(nickname)

nickname = "andwecrawl"

print(nickname) // Optional()...


// 1. 강제 해제 연산자
print(nickname!)

if nickname!.count > 2 {
    print("\(nickname!)입니다.")
} else {
    print("세 글자 이상 작성해 주세요.")
}


// 2. 조건문으로 nil 판단하여 만일에 발생할 수 있는 런타임 오류 방지 가능

if nickname != nil {
    print("\(nickname!)입니다.")
}


// 3. 옵셔널 바인딩
// nickname이 optional type인데, nil이 아닌 경우에 name으로 optional이 벗겨져서 담김!!
if let nickname = nickname {
    print("\(nickname)입니다.")
}

if let value = nickname, let age = age {
    print("\(value), \(age)입니다.")
}


// swift5.7 if let shorthand
if let nickname, let age {
    print("\(nickname), \(age)")
}


nickname = nil
func testOptionalBinding() {
    if let nickname {
        print("\(nickname)")
        // if let의 경우에는 해당 변수를 안쪽에서만 쓸 수 있음
    }
    
    guard let name = nickname else {
        print("nil")
        return // nil일 때 early exit
    }
    // guard let의 경우에는 해당 변수를 바깥쪽에서 쓸 수 있음
    // 안쪽에서는 불가!
    // else {...} 안에서는 못 쓴다는 거!!
    // guard는 무조건 return이나 throw가 필요함!
    // 이렇게 걸러주지 않으면 이후 런타임 오류가 생길 수 있으므로 else {...}문 안에서 알아서 끊어주는 거임
    
}

testOptionalBinding()


func searchWords() {
    let example: String? = "신조어"
    
    if example != nil {
        
    }
    
    if let example {
            
    }
    
    guard let example = example else {
        print("문제 발생!")
        return
    }
    
}


