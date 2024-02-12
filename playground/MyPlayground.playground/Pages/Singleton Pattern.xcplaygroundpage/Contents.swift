//: [Previous](@previous)

import Foundation

enum Singleton {
    var number: Int {
        get {
            return
        }
    }
    static let shared: Singleton = Singleton()
    
    private init() { }
    
}

var singleton1: Singleton = Singleton.shared
var singleton2: Singleton = Singleton.shared

print(singleton1.number, singleton2.number)
singleton1.number = 5
print(singleton1.number, singleton2.number)
print(singleton1, singleton2)

//: [Next](@next)
