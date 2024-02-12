//: [Previous](@previous)

import Foundation

// 매개변수 X 반환값 X
func welcome() {
    print("안녕하세요 반갑습니다")
}

// 반환값은 생략을 해서 써도 무방함
// 만약에 반환값은 없지만 매개변수가 있는 상태로 만들고 싶다~ 하면 위에 복사해서 매개변수 맹글 수 있음


// 매개변수 O 반환값 X
func welcome(name: String) {
    print("안녕하세요, \(name)님. 반갑습/습니다!")
}


// 함수 이름이 같더라도 매개변수나 반환값이 다르면 사용할 수 있는 특성 -> 오버로딩

welcome()

/*
 변수 / 상수나 데이터 구조 내에 자료형을 저장할 수 있다.
 함수의 반환값으로 자료형을 사용할 수 있다.
 함수의 인자값으로 자료형을 전달할 수 있다.

 */


// 반환갑셍서 사용되는 거 -=> message -> () // 함수 호출 연산자가 없음!!
// 1급 객체다~
// 각각의 함수가 케이스를 가지고 있다




func checkBankInformation(bank: String) -> Bool {
    
    let bankArray = ["우리", "신한", "국민", "농협", "하나"]
    return bankArray.contains(bank) ? true : false
    
}


// 변수나 상수에 함수를 실행해서 반환된 반환값을 대입한 것 (1급 객체의 특성은 아님)
// 1급 시민이 더 자유도가 높았다! 1급 객체들은 이것저것 더 할 수 있당
let result = checkBankInformation(bank: "하나")


// 변수나 상수에 함수 그 '자체'를 대입할 수 있다. (1급 객체의 특성)
// 함수만 대입한 것으로, 함수가 실행된 상태는 아니다.

let checkAccount = checkBankInformation

checkAccount("신한")


// 함수 타입 (String) -> Bool: Function Type(ex.Tuple에 자주 사용)
// 어떤 매개변수를 가지고 있냐, 어떤 반환값을 가지고 있냐에 따라서 무수히 많이 나올 수 있음
// 그냥 퉁 쳐서 함수 타입이라고 함

// tuple Example
let tupleExample = (1, 2, 33, "hello", true)
tupleExample.2


// (String) -> String
func hello(username: String) -> String {
    return "저는 \(username)입니다."
}

func hello(username: String, age: Int) -> String {
    return "저는 \(age)살, \(username)입니다."
}


/*
 오버로딩 특성으로 함수를 구분하기 힘들 때,
 타입 어노테이션을 통해서 함수를 구분할 수 있다.
 */

let example = hello(username:)
example("해파리")


// 2. 함수의 반환 타입으로 함수를 쓸 수 있다.





func currentAccount() -> String {
    return "계좌 있다는 얼럿 띄우기"
}

func noCurrentAccount() -> String {
    return "계좌 없으니 생성 화면으로 이동"
}

func checkBank(bank: String) -> () -> String {
    let bankArray = ["신한", "우리", "농협", "국민"]
    return bankArray.contains(bank) ? currentAccount : noCurrentAccount
    // 함수를 호출하는 건 아니고, 함수를 던져줌!
}


func plus(a: Int, b: Int) -> Int
{
    return a+b
}

func minus(a: Int, b: Int) -> Int
{
    return a - b
}

func multiply(a: Int, b: Int) -> Int
{
    return a * b
}

func divide(a: Int, b: Int) -> Int
{
    return a / b
}

//함수 자체가 한 가지의 기능만 가질 수 있또록 하는 거잉
func calculate(operand: String) -> (Int, Int) -> Int {
    switch  operand {
    case "+": return plus
    case "-": return minus
    case "*": return multiply
    case "/": return divide
    default: return plus
        
    }
}

calculate(operand: "+")(3, 4)//  함수가 실행되고 있는 상태가 아님)

// 3. 함수의 인자값으로 함수를 사용할 수 있다.
func oddNumber() {
    print("홀수")
}

func evenNumber() {
    print("짝수")
}

func setLabel() {
    

}

func setNavigationBar() {
    
}


func resultNumber(number: Int, odd: () -> Void, even: () -> Void) {
    return number.isMultiple(of: 2) ? even() : odd()
}

resultNumber(number: 5, odd: oddNumber, even: evenNumber)



resultNumber(number: 29, odd: { print("홀수") }, even: { print("짝수") })
    // 의도하지 않은 함수가 들어갈 수 있고, 피요 이상의 함수가 자꾸 생성될 수 있음
// 따라서, 우리는 읾 있는 함수를 만들지 않고 closure를 통해서 이름 ㅇ벗는 함수를 ㅓㄴㅎㄱ 됨.

resultNumber(number: <#T##Int#>) {
    <#code#>
} even: {
    <#code#>
}



//: [Next](@next)
