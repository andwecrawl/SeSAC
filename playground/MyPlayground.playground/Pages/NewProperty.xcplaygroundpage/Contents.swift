//: [Previous](@previous)

import Foundation

// 프로퍼티: 인스턴스 프로퍼티 (클래스 / 구조체를 초기화해야 프로퍼티에 접근 가능)

struct User {
    var nickname: String
    // 변수를 생성할 때 선언과 초기화를 동시에 할 수도 있고
    // 선언만 해 두고 인스턴스 생성 시 초기화해도 ㄱㅊ
    // 인스턴스 프로퍼티 + 저장 프로퍼티
    
    static var originName: String = "진짜 이름"
    // 타입 프로퍼티이자 저장 프로퍼티
    // 사용하게 되는 순간 메모리에 올라감 / 앱 종료시까지 메모리에 유지됨
    // 지연 저장 프로퍼티(lazy)처럼 동작한다.
    
    // 인스턴스 프로퍼티 + 연산 프로퍼티
    // 값을 초기화하고 저장할 수 있는 공간 X => 저장 프로퍼티 X
    // 다른 저장 프로퍼티의 값을 연산해서 간접적으로 값을 제공함
    var userIntroduce: String {
        get {
            return "사용자의 닉네임은 \(nickname)이고, 진짜 이름은 \(User.originName)입니다."
            // 타입 프로퍼티는 User.originName으로 써야 함
            // originName으로 작성 불가
        }
    }
}

let user = User(nickname: "neenee")

// User.nickname <- 불가!
// 기본적으로 인스턴스 프로퍼티이기 때문에 구조체 인스턴스를 선언해야 내부의 프로퍼티에 접근할 수 있다.

user.nickname // 인스턴스 프로퍼티 => 초기화 해야 접근 가능
User.originName // 인스턴스로는 접근 불가능!!! 타입 프로퍼티라 그런듯? 인스턴스 프로퍼티가 아니라


let user2 = User(nickname: "jellyfish")
user2.nickname

let user3 = User(nickname: "ddoddo")
user3.nickname

User.originName // 인스턴스가 아무리 많이 만들어져도 영향 X
// 한 공간에만 저장되어 있음
// 인스턴스가 아무리 많더라도 type property는 하나!


// label.text = "사용자의 닉네임은 \(user2.nickname)이고, 진짜 이름은 \(User.originName)입니다."
// label.text = user3.userIntroduce

// struct 안에 description을 추가해서 만들어 사용하면 간편하고 코드가 깔끔해져서 좋음

// 똑같은 객체를 표현할 때 뷰 객체를 많이 쓰지 않는 게 더 좋음
// 더욱 다양한 데이터를 하나의 레이블에 사용하는 게 더 이득인듯?
// 레이아웃 잡을 때도 뷰가 쌓이다 보면 로드하는 데 시간이 느리고 저전력모드나 배터리가 얼마 안 남았을 때는 안 좋음.
// 최소한의 뷰나 기능으로 레이아웃을 만드는 게 최적화 관점에서는 더 좋다아아앙



struct BMI {
    var nickname:  String { // 저장 프로퍼티
        willSet {
            print("닉네임이 \(nickname)에서 \(newValue)로 변경될 예정입니다.")
        }
        didSet {
            print("\(oldValue)에서 \(nickname)로 바뀌었습니다.")
        }
    }
    
    // 인스턴스 프로퍼티이자 저장 프로퍼티임
    var weight: Double
    var height: Double
    
    // get을 사용해서 저장 프로퍼티를 이용하여 연산 프로퍼티 값을 구할 수 있음
    var BMIResult: String {
        get {
            let bmiValue = weight / (height * height)
            let bmiState = bmiValue < 18.5 ? "저체중" : "정상 이상"
            return ("\(nickname)님의 BMI 지수는 \(bmiValue)로 \(bmiState) 상태입니다.")
        }
        set {
            nickname = newValue
        }
    }
}

var bmi = BMI(nickname: "opq", weight: 70, height: 180)

bmi.nickname = "hello"
print(bmi.BMIResult)

let bmiValue = (bmi.weight * bmi.weight) / bmi.weight

let bmiState = bmiValue < 18.5 ? "저체중" : "정상 이상"

//print("gg님의 BMI 지수는 \(bmiValue)로 \(bmiState) 상태입니다.")

bmi.BMIResult


/*
 
 함수로 만들어서 쓰는 것과 연산 프로퍼티로 만드는 게 뭐가 다른데?
 
 둘이 물 가르듯이 나누어져 있지는 않은데, 함수가 조금 더 로직이 복잡한 단위이다.
 조건에 따라서 반환 값이 여러 개로 나뉘는 경우!!
 
 연산 프로퍼티가 단위 자체가 작음
 그냥 안에 저장 프로퍼티를 이용하여 간단한 연산을 하는 경우와 같이 큰 로직이 필요하지 않은 경우에 주로 사용함
 
 */


// 타입 프로퍼티는 타입 프로퍼티끼리 / 인스턴스 프로퍼티는 인스턴스 프로퍼티끼리 쓸 수 있기 때문에 구분하는 게 중요함!!
// 타입 / 인스턴스 프로퍼티에 대한 부분!!
// 저장 / 연산 프로퍼티!!



// 열거형은 컴파일 타임에 정해짐!!
// 초기화가 안 댐!!
// 중 요

// static let으로 값을 저장하는 것과 case rawValue로 값을 저장하는 것의 차이?
enum Grade {
    case A, B, C, D, E
}

// 따라서, 열거형은 초기화가 불가능!!
// 인스턴스 생성도 할 수 없음
// 인스턴스 프로퍼티와 메서드를 사용할 수 없음 => 저장 프로퍼티를 가질 수 없어!!
// 근데 연산 프로퍼티나 함수는 가능하다네요 ^_^
// 다만 타입 프로퍼티는 가능!!
// 대신 컴파일 타임에 처리되니까 초깃값은 정해줘야 함


enum Resource: String {
    case save = "저장"
    case add = "추가"
    
    static let addIcon = "추가"
    static let addButton = "추가"
}


// 버튼의 String값과 바 아이템의 String 값이 같을 때?
// enum에
/*
 enum Resource: String {
     case save = "저장"
     case add = "추가"
     case addButton = "추가" // 오류남
 }
 */

// 이때!! 같은 값을 static let을 통해서 다르게 표현할 수 있다.
// static let => 의미 단위로 같은 변수를 사용할 수 있고,
// RawValue의 경우에는 같은 값을 사용할 수 없다.
// 그렇기 때문에 의미를 명확히 하기 위해서!!
// static let을 사용할 수 있다.




class Hamster {
    
    static let species: String = "Hamster"
    static var count: Int = 0
    
    
    var name: String
    var weight: Double
    
    init(name: String, weight: Double) {
        self.name = name
        self.weight = weight
        Hamster.count += 1
    }
}




class yeonee {
    class func hello() {
        print("hello?")
    }
    
    static func hi() {
        print("hi?")
    }
}

class neeenee: yeonee {
    override class func hello() {
        print("hello!")
    }
}


enum Media {
  case book(title: String, author: String, year: Int)
  case movie(title: String, director: String, year: Int)
  case website(urlString: String)
}

let book = Media.book(title: "The Fault in Our Stars", author: "John Green", year: 2012)

if case let Media.book(title, _, _) = book {
    print("This is a book named \(title)")
}

switch book {
  case let Media.book(title, _, _):
    print("This is a book named \(title)")
  default: ()
}

let movie = Media.movie(title: "Carol", director: "Todd Haynes", year: 2015)

func hello(element: Media) {
    guard case let Media.movie(title, _, _) = element else {
        print("not exist")
        return
    }
    print("The movie named \(title) is exist")
}

hello(element: book)
hello(element: movie)
//: [Next](@next)




class FoodResturant {
    let name = "잭 치킨"
    
    var totalOrderCount = 10
    
    // 하나의 프로퍼티를 활용해서 값을 넣어줄 수도 있고 꺼내줄 수도 있음
    var newOrder: Int {
        get {
            return totalOrderCount * 5000
        }
        set {
            totalOrderCount += newValue
        }
    }
}

let food = FoodResturant()

food.newOrder = 20
food.newOrder
food.totalOrderCount



class ChickenChicken {
    static let name = "연히 치킨"
    
    static var totalOrderCount = 10 {
        willSet {
            print("총 주문 건수가 \(totalOrderCount)에서 \(newValue)로 변경될 예정입니다!")
        }
        didSet {
            print("총 주문 건수가 \(oldValue)에서 \(totalOrderCount)로 변경되었습니다!")
        }
    }
    
    static var newOrder: Int {
        get {
            return totalOrderCount * 5000
        }
        set {
            totalOrderCount += newValue
        }
    }
    
}

ChickenChicken.newOrder = 20
ChickenChicken.totalOrderCount
ChickenChicken.newOrder




struct Coffee {
    static var name = "아메리카노"
    static var shot = 2
    
    static func plusShoot() {
        shot += 1
    }
}

Coffee.plusShoot()
print(Coffee.shot)

class Latte: Coffee {
    
    // 상속이 가능하다면 이렠 오버라이딩 함수가 뜸
    override class func plusShot() {
        // ㅓㅇ쩌구
    }
}
