//: [Previous](@previous)

import Foundation


// 클로저에서 언제 캡쳐가 필요한지 왜 문법이 이렇게 쓰이는지? 를 물어봄
// 메모리 관점에 대한 이야기보다는 구현이 되는 동작방식을 이해하는 시간이라고 보면 될 것 같음

/*
 함수가 두 가지 종류가 있음.
 1. 이름이 있는 함수 => 메서드 함수
 2. 이름이 없는 함수 => 익명 함수
 
 func로 시작하는 함수들은 이름이 있는 함수들임 ^_^
 근데 굳이 한 번만 사용하고 말 거라면? 이름을 붙여 줄 필요가 없을 것이다.
*/

// () -> (), () -> Void
func studyiOS() {
    print("주말에도 공부하기")
}


let study: () -> () = {
    print("주말에도 공부하기")
}

study // 함수의 내용
study() // 함수의 실행

// closure header(in 기준으로 앞에 있는 친구) / in / closure body(in 기준으로 뒤에 있는 친구)
let studyHarder = { () -> () in
    print("주말에도 공부하기")
}

// 함수를 상수에 넣을 수 있는 거 자체가 Swift 언어가 가지고 있는 함수의 특성이 1급 객첵이기 때문이다.
/*
 1급 객체의 특징
 변수 / 상수나 데이터 구조 내에 자료형을 저장할 수 있다.
 함수의 반환값으로 자료형을 사용할 수 있다.
 함수의 인자값으로 자료형을 전달할 수 있다.
 */

func getStudyWithMe(study: () -> ()) {
    print("주말에도 공부하깅...")
    study()
}


// 코드를 전혀 생략하지 않고, 클로저 구문을 사용한 상태. 함수의 매개변수 내에 클로저가 그대로 들어간 형태
// 인라인(inline) 클로저
getStudyWithMe(study: { () -> () in
    print("주말에도 공부하기")
})


// 함수 뒤에 클로저가 실행
// 후행 클로저(Trailing Closure)
getStudyWithMe() { () -> () in
    print("주말에도 공부하기")
}


// 결국 알고 있는 내용의 확장임!
// 매개변수에 함수 넣고 상수에 함수 넣고~
// 랜덤으로 숫자를 뽑아주는 함수를 만들어서 어떻게 클로저 구문이 생략이 되는지 함 보려구 함


// (Int) -> String
func example(number: Int) -> String {
    return "\(number)"
}

example(number: Int.random(in: 1...100))


func randomNumber(result: (Int) -> String) {
    result(Int.random(in: 1...100))
}

randomNumber(result: { (number: Int) -> String in
    return "행운의 숫자는 \(number)입니다."
})

// type annotation으로 closure header에서 반환값 생략 가능
randomNumber(result: { (number) in
    return "행운의 숫자는 \(number)입니다."
})


// 매개변수의 타입을 알아서 찾아줘서 매개변수 타임 또한 생략 가능!!
randomNumber(result: { (number) in
    return "행운의 숫자는 \(number)입니다."
})



// 매개변수를 생략하면 할당되어 있는 내부 상수 $0 를 사용할 수 있다.
// swift 5.1 함수의 실질적인 내용이 한 줄일 경우 return 생략 가능
randomNumber {
    return "행운의 숫자는 \($0)입니다."
}


// 하 ㅋㅋ 개웃김





let student = [2.2, 4.5, 3.2, 4.9, 3.3, 2.2, 1.7]

var newStudent: [Double] = []

for item in student {
    if item >= 4.0{
        newStudent.append(item)
    }
    print(newStudent
)
}

let number = [Int](1...100)
var newNumber : [Int] = []


for number in number {
    newNumber.append(number * 3)
}

print(newStudent)



// map: 기존의 요소를 클로저를 통해 원하는 결괏값으로 변경


let mapNumber = number.map { $0 * 3 }

let mapResult = number.map { "\($0)번입니다."}

print(mapNumber)
print(mapResult)



let movieList = [
    "괴물": "박찬욱",
    "기생충": "봉준호",
    "인셉션": "크리스토퍼 놀란",
    "인터스텔라": "크리스토퍼 놀란"
]

// 특정 감독의 영화만 출력
let movieReuslt = movieList.filter { $0.value == "봉준호"}

let movieResult2 = movieList.filter { $0.key == "인셉션"}









//: [Next](@next)
