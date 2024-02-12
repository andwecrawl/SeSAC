//: [Previous](@previous)

import UIKit

enum DrinkSize {
    case short, tall, grande, venti
}


// 음료 주문: 이름, 가격, 사이즈
class DrinkClass {
    // 얘네 앞은 인스턴스 프로퍼티
    let name: String
    var price: Int
    var size: DrinkSize
    
    // static 잇으면 type property
    
    init(name: String, price: Int, size: DrinkSize) {
        self.name = name
        self.price = price
        self.size = size
    }
}

// memberwise Initializer
struct DrinkStruct {
    let name: String
    var price: Int
    var size: DrinkSize
}

// Class의 경우 변수의 주솟값 고정 / 값은 바꿀 수 있음
let lunchDrink = DrinkClass(name: "아샷추", price: 3000, size: .grande)
let dinnerDrink = DrinkClass(name: "아이스 아메리카노", price: 1500, size: .grande)
lunchDrink.price = 3500
lunchDrink.size = .venti

// let일 때는 어떤 내용도 수정할 수 X (struct)
let nextLunchDrink = DrinkStruct(name: "아샷추", price: 3000, size: .grande)
//nextLunchDrink.price = 2000
//nextLunchDrink.name = "샷샷추"
//nextLunchDrink.size = .short




struct Poster {
    var image: UIImage = UIImage(systemName: "star") ?? UIImage()
}




// 넷플릭스: 영화 타이틀, 러닝타임, 고화질 포스터나 영상...
struct Movie {
    
    static let best: String = "이달의 최고 영화"
    // 저장 프로퍼티이자 타입 프로퍼티로 저장 타입 프로퍼티라고 함
    // static: 타입 프로퍼티로 기본적으로 lazy로 동작함
    
    let name: String
    let runtine: Int
//    lazy var viedo: Poster
    // 지연 저장 프로퍼티 lazy.
    // 상수는 인스턴스가 생성되기 전에 항상 값을 가지고 있어야 함.
    
    init(video: Poster) {
        self.init(video: video)
    }
    
}

// 변수 상수 -> property // 인스턴스 / 타입 프로퍼티
                        // 저장 & 연산
// 함수               // 인스턴스 / 타입 method
                    // 초기화로 초기값 설정


// 도둑들 명량 아바타 알라딘 암살
//어벤져스엔드게임 왕의남자 태극기휘날리며 택시운전사 해운대


//: [Next](@next)
