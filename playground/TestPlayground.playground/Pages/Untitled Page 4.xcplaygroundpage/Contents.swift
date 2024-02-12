//: [Previous](@previous)

import Foundation

// propertyWrapper에는 무조건~! wrappedValue가 구현되어 있어야 함
@propertyWrapper // attribute들을 한번 감싸서 사용하는 거!! :3
struct YeoniDefaults<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
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
    
    @YeoniDefaults(key: Key.email.rawValue, defaultValue: "이메일 없음")
    static var email
    
    @YeoniDefaults(key: Key.nickname.rawValue, defaultValue: "닉네임 없음")
    static var nickname
    
    @YeoniDefaults(key: Key.phone.rawValue, defaultValue: 01012345678)
    static var phone
    
}

UserDefaultManager.email = "2@r.com"

print("\(UserDefaultManager.email)")
print(UserDefaultManager.email)

UserDefaultManager.phone
UserDefaultManager.phone = 232323
UserDefaultManager.phone
//: [Next](@next)
