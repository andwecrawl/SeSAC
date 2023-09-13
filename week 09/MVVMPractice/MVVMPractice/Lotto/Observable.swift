//
//  Observable.swift
//  MVVMPractice
//
//  Created by yeoni on 2023/09/14.
//

import Foundation

class Observable<T> {
    
    var listener: ((T) -> ())?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> ()) {
        closure(value)
        listener = closure
    }
}
