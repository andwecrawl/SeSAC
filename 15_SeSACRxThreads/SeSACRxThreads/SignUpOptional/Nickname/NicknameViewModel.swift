//
//  NicknameViewModel.swift
//  SeSACRxThreads
//
//  Created by yeoni on 2023/11/03.
//

import Foundation
import RxSwift
import RxCocoa

class NicknameViewModel {
    
    let nickname = BehaviorSubject(value: "")
    let isHidden = BehaviorSubject(value: false)
    
    let disposeBag = DisposeBag()
    
    init() {
        
        nickname
            .map({ $0.count > 1 && $0.count < 6 })
            .bind(with: self, onNext: { object, value in
                object.isHidden.onNext(!value)
            })
            .disposed(by: disposeBag)
        
    }
    
    
}
