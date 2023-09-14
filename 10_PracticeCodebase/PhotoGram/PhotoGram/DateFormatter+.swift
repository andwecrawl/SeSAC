//
//  DateFormatter+.swift
//  PhotoGram
//
//  Created by yeoni on 2023/08/29.
//

import Foundation

// dateFormatter => cost 많이 들음
// 따라서, 사용할 때 별개의 인스턴스를 매번 만드는 것보다 미리 인스턴스를 구현해 놓고 사용하는 것이 좋음

extension DateFormatter {
    
    static let format = {
        let format = DateFormatter()
        format.dateFormat = "yy년 MM월 dd일"
        return format
    }()
    
    static func today() -> String {
        return format.string(from: Date())
    }
    
    static func convertDate(date: Date) -> String {
        return format.string(from: date)
    }
}
