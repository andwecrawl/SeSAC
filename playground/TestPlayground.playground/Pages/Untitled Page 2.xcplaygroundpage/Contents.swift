//: [Previous](@previous)

import Foundation

// 열거형 => 인스턴스 생성 X
    // 인스턴스 메소드나 프로퍼티 사용불가
enum UserDefaultManager {
    private enum Key: String {
        case email
        case nickname
        case phone
    }
    
    static var email: String {
        get {
            UserDefaults.standard.string(forKey: Key.email.rawValue) ?? "이메일 없음"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.email.rawValue)
        }
    }
    
    static var nickname: String {
        get {
            UserDefaults.standard.string(forKey: Key.nickname.rawValue) ?? "이메일 없음"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.nickname.rawValue)
        }
    }
    
    static var phone: String {
        get {
            UserDefaults.standard.string(forKey: Key.phone.rawValue) ?? "이메일 없음"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.phone.rawValue)
        }
    }
}

UserDefaultManager.email = "2@r.com"

print("\(UserDefaultManager.email)")
print(UserDefaultManager.email)
//: [Next](@next)
