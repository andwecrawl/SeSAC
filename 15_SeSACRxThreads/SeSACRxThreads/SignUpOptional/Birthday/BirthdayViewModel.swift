//
//  BirthdayViewModel.swift
//  SeSACRxThreads
//
//  Created by yeoni on 2023/11/03.
//

import Foundation

import RxSwift
import RxCocoa

class BirthdayViewModel {
    
    let birthday: BehaviorSubject<Date> = BehaviorSubject(value: .now)
    
    let year = BehaviorSubject(value: 0)
    let month = BehaviorSubject(value: 0)
    let day = BehaviorSubject(value: 0)
    
    let isEnabled = BehaviorSubject(value: false)
    
    let disposeBag = DisposeBag()
    
    
    init() {
        birthday
            .subscribe(with: self) { owner, date in
                let components = Calendar.current.dateComponents([.year, .month, .day], from: date)
                
                if let year = components.year, let month = components.month, let day = components.day {
                    owner.year.onNext(year)
                    owner.month.onNext(month)
                    owner.day.onNext(day)
                }
                
                let compareResult = date.compare(Date().beforeSeventeenYears)
                let isValid = compareResult == .orderedDescending ? false : true
                owner.isEnabled.onNext(isValid)
            }
            .disposed(by: disposeBag)
    }
    
}
