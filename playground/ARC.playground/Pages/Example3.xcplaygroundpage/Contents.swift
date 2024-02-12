//: [Previous](@previous)

import Foundation

// heap => 참조타입이 들어가게 댐!!

class User {
    var nickname = "yeoni"
    
    // 동시에 인스턴스가 생성되면 안 되기 땜에 생성 시점을 조금 미뤄주기!!
    lazy var introduce: () -> String = { [weak self] in // context , captureList / RC +1
        return "안녕하세요 \(self?.nickname) \(Int.random(in: 1...100))입니다." // self 사용 시에~~!
    }
    
    init() {
        print("User Init")
    }
    
    deinit {
        print("User Deinit")
    }
}

var user: User? = User() // init

let result = user?.introduce

print(result!())

user = nil // deinit / nickname X

// user가 가지고 있는 함수가 살아서 움직이고 있음~~!
print(result!())
    // 여기서 왜??
    // nickname이 없는데 nickname이 있는 상태에 봉착~~!

/*
 함수, 변수의 생명 주기(scope)
 함수 내부에서 self keyword의 경우 혹시 이후에 인스턴스의 값이 없어질 수 있으니까
 해당 값을 캡쳐해 놓게 댐!!
 나중에 해당 인스턴스가 사라지더라도 해당 값을 사용할 수 있도록!
 
 주변 환경 / context
    => user의 입장에서는 nickname
    그러니까 내가 사용하고 있는 property 같은 것들!!
    closure는 주변 환경 / context를 캡쳐하여 추후에 인스턴스 값이 없어졌을 때를 대비하게 댄다!!
    근데 주변환경을 캡쳐하게 대면 deinit이 실행되지 않음 .. ..................
    
 클로저 내의 캡쳐는 하되 너무 RC는 올리고 싶지 않아! 한다면 .. ..
 
 { [weak self // 클래스의 인스턴스 자체를 설정!] in // context , captureList / RC +1
     return "안녕하세요 \(self?.nickname)입니다." // self 사용 시에~~!
 }
 */








//: [Next](@next)
