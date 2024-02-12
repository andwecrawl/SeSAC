//: [Previous](@previous)

import Foundation

@propertyWrapper
struct Decimal {
    var defaultValue: String
    
    var projectedValue = "냠냠"
    
    var wrappedValue: String {
        get {
            defaultValue
        }
        set {
            let result = Int(newValue) ?? 0
            defaultValue = "\(result.formatted())원" // iOS 15 formatter
            projectedValue = "이체할 금액은 총 \(result.formatted())원이에용"
        }
    }
}



struct Example {
    
    @Decimal(defaultValue: "0원")
    var number
    
}

var example = Example()
example.number = "20000"
example.number
example.$number // propertyWrapper에서 projectedValue로 해당 값을 설정해 주면서 나온 거임 :3

//: [Next](@next)
