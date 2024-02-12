//: [Previous](@previous)

import Foundation

@propertyWrapper
// @State / @binding / @Environment 같은 요소들도 내부에 이런 식으로 구성되어 있음
struct Decimal {
    var defaultValue: String
    
    var wrappedValue: String {
        get {
            defaultValue
        }
        set {
            let result = newValue.uppercased()
            defaultValue = result // iOS 15 formatter
        }
    }
}



struct Example {
    
    @Decimal(defaultValue: "HELLO")
    var uppercase
    
}

var example = Example()
example.uppercase = "hello jito hello"
example.uppercase
//: [Next](@next)
