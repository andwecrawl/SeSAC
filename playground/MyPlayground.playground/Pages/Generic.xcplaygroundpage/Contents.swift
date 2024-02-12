//: [Previous](@previous)

import Foundation

func genericTest<T: AdditiveArithmetic>(num1: T, num2: T) {
    print(T.self)
    print(num1, num2)
}

genericTest(num1: 1.3, num2: 2)

//: [Next](@next)
