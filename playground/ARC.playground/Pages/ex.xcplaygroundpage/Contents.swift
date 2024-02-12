//: [Previous](@previous)

import Foundation

class Customer {
    let name: String
    var card: CreditCard?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("Goodbye, \(name)!")
    }
}

class CreditCard {
    let number: Int
    unowned let customer: Customer
    
    init(number: Int, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    
    deinit {
        print("Goodbye, \(number)!")
    }
}

var yeoni: Customer? = Customer(name: "yeoni")

yeoni!.card = CreditCard(number: 12345678, customer: yeoni!)

yeoni = nil

//: [Next](@next)
