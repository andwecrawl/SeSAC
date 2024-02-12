//: [Previous](@previous)

import Foundation

struct User {
    
    let name = "고래밥" // 인스턴스 프로퍼티
    static let originalName = "neenee" // 타입 프로퍼티
    
    
    
}

let user = User()

user.name

type(of: user.name)

type(of: user)

// 메타 타입 ) 타입의 타입


// 고래밥 => String
// String => String.Type

user.self.originatorNameComponentsz


let number: Int = 8.self

let result: Int.Ty[kce] = Int








// 메타 타입은 클래스 구조체 열거형 등의 유형 그 자체를 가리킴


//: [Next](@next)
