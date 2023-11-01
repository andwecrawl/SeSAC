//
//  Extension+Date.swift
//  SeSACRxThreads
//
//  Created by yeoni on 2023/11/01.
//

import Foundation

extension Date {
    var startOfTheDate: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var beforeSeventeenYears: Date {
        let targetDate = self.startOfTheDate
        let result = Calendar.current.date(byAdding: .year, value: -17, to: targetDate)!
        return result
    }
}
