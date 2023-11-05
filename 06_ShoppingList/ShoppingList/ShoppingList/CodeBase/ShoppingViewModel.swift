//
//  ShoppingViewModel.swift
//  ShoppingList
//
//  Created by yeoni on 2023/11/05.
//

import Foundation
import RxSwift
import RxCocoa

class ShoppingViewModel {
    
    var data = Shopping()
    
    var list: BehaviorSubject<[Stuff]>
    
    let disposeBag = DisposeBag()
    
    init() {
        list = BehaviorSubject(value: data.list)
    }
    
}
