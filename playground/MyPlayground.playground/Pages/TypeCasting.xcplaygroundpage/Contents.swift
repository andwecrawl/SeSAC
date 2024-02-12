//: [Previous](@previous)

import Foundation

// 형 변환 => 타입 변환
// 타입 캐스팅
let number = 3
let numberToString = String(number)

// 이니셜라이저 구문을 통해 새롭게 인스턴스를 생성한 것 => 형변환
// 형 변환 => 새로운 인스턴스를 생성하는 것뿐임 ㅇㅇ


//print(type(of: number))
//print(type(of: numberToString))


class Mobile {
    let name: String
    
    init(name: String) {
        self.name = name
        
    }
    
}


class Google: Mobile {
    
}

class Apple: Mobile {
    let conference = "WWDC"
}

// is 연산자: 어떤 클래스의 인스턴스 타입인지 확인할 수 있음


let mobile = Mobile(name: "phone")
let google = Google(name: "google")
let apple = Apple(name: "apple")

mobile is Mobile
mobile is Apple
mobile is Google

apple is Mobile
apple is  Google
apple is Apple

let iphone: Mobile = Apple(name: "iPhone Pro Max")

type(of: iphone)

iphone.name
// iphone.conference // Apple이 가지고 있는 프로퍼티에 접근할 수 없음.

// 타입 캐스팅을 통해 원하는 프로퍼티에 접근할 수 있도록 설정할 수 있다.
// Type Cast Operator: as(upCasting) / as? as! (downCasting)
// UIKit은 상속관계로 이루어져 있어서 as로 접근하는 경우가 많다.

// as? 옵셔널 반환 타입 => 실패할 경우 nil 반환
// as! 옵셔널 타입 아님 => 실패할 경우 무조건 런타임 오류 발생함

if let value = iphone as? Apple {
    print(value.conference)
}

if let value  = iphone as? Google {
    print("hi google")
} else {
    print("failed!")
}

// 아까 cell = UITableViewCell as! CustomTableViewCell
// 다운캐스팅해서 각각에 접근했던 거임
// 한 단계씩 내려갈 때 사용하게 댐
// 애플의 코드에서 응용하는 시간을 가지면 댐!!
// 따라서 가드로 선언하기도 함


// Any: 모든 타입에 대한 인스턴스를 담을 수 있음 vs AnyObject: 클래스의!! 인스턴스만 담을 수 있음
// protocol의 경우 AnyObject를 자주 사용하기도 함
// 컴파일 시점에서는 어떤 타입인지 확인할 수 없고, 런타임 시점에 타입이 결정댐
var arr: [Any] = ["a", "b", "c", true, 1, 2]

arr.append(false)
arr.append(2.2)
arr.append(mobile.name)
arr.append("hello")

print(arr)
print(arr[5])

let element = arr[4]

element as! Int + 1

if let value = element as? Int {
    print(value)
} else {
    print("숫자가 아녓네요")
}


if let value = element as? String {
    print(value)
} else {
    print("문자열이 아녓네요")
}

//: [Next](@next)
