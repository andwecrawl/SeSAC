//: [Previous](@previous)

import Foundation

struct YeoniDefaults<T> {
    let key: String
    let defaultValue: T
    
    var value: T {
        get {
            UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
    
}

// 열거형 => 인스턴스 생성 X
    // 인스턴스 메소드나 프로퍼티 사용불가
enum UserDefaultManager {
    enum Key: String {
        case email
        case nickname
        case phone
    }
    
    static var email = YeoniDefaults(key: Key.email.rawValue, defaultValue: "이메일 없음")
    
    static var nickname = YeoniDefaults(key: Key.nickname.rawValue, defaultValue: "이메일 없음")
    
    static var phone = YeoniDefaults(key: Key.phone.rawValue, defaultValue: "454545")
    
}

UserDefaultManager.email.value = "2@r.com"

print("\(UserDefaultManager.email.value)")
print(UserDefaultManager.email)

UserDefaultManager.phone.value
UserDefaultManager.phone.value
UserDefaultManager.phone.value
//: [Next](@next)
