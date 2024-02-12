import UIKit

// 생성자가 없어요!
// 클래스 내 모든 프로퍼티는 초기화가 되어 있어야 한다.
// 1. 선언과 동시에 초기화를 진행하기
// 2. optional로 선언하깅
// 3. 매개변수를 만들기 => 초기화 구문을 만들기
class BabyMonster {
    var name: String
    var exp: Int
    var speed: Int
    var power: Int
    
    // 초기화 구문
    init(name: String, exp: Int, speed: Int, power: Int) {
        self.name = name
        self.exp = exp
        self.speed = speed
        self.power = power
        // self => 클로저 다룰 때도 설명
        // 각각 다른 매개변수명을 잘 안 쓰고, class 내부에 있는 변수를 말함.
        
    }
}

// 상속이랑 섞이면 설명할 게 정말 많음!
// 초기화 구문 셋팅 완료 / 모든 프로퍼티 초기화가 필요함!!


struct MonsterBaby {
    var name: String
    var exp: Int
    var speed: Int
    var power: Int
    
    // 초기화 구문
        // self => 클로저 다룰 때도 설명
        // 각각 다른 매개변수명을 잘 안 쓰고, class 내부에 있는 변수를 말함.
}


let baby = BabyMonster(name: "예원", exp: 0, speed: 7, power: 1)
baby.speed = 5


var nickname = "졸린 바다사자"
var subNickname = nickname

nickname = "바다사자"

print(nickname)
print(subNickname)











// 게임을 만든다구 해 보자.

/*
 몬스터를 구성하는데는 뭐가 필요할까?
 exp
 clothes
 speed
 power
 */

// 쉬운 몬스터
// 변수랑 함수를 묶어 놓는 친구!
class Monster {
    var exp = 1
    var clothes = "white"
    var speed = 1
    var power = 1
    
    func attack() {
        print("attack!!!")
    }
}

// 비슷한 기능끼리 묶어놓은 집합이라고 보면 된다!
// 클래스 호출 시에도 괄호 사용

let easy = Monster()
let hard = Monster()
hard.exp = 100
hard.clothes = "red"
hard.speed = 20
hard.power = 1000

// class: 틀로써 존재하다가 변수를 선언 후 인스턴스를 생성하여 실재하게 됨.
// 필요한 순간에만 사용할 수 있게 맹그는 거임!!
// 말 그대로 틀만 만들어져 있고 (구성만 해 두고) 사용 X
// 이후 필요하다면 초기화 => app의 메모리 공간을 차지한다.
// 초기화 = instance 생성

// bossMonster는 Monster를 상속받고 있기 때문에
// Monster가 가지고 잇는 변수를 사용할 수 있다.
// -> BossMonster: SubClass
// Monster
class BossMonster: Monster {
    
    var specialItem = "마법고리"
    
    override func attack() {
        print("boss attack1")
    }
}

let boss = BossMonster()
boss.specialItem
boss.exp
boss.power
boss.speed
boss.clothes



// 필요한 사항을 묶어 놓고 쓸 때 실제적인 값을 넣어주면 안 될까?
