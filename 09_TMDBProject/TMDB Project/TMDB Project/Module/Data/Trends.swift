//
//  Trends.swift
//  TMDB Project
//
//  Created by yeoni on 2023/11/19.
//

import Foundation

enum Trends: String {
    case all, movie, tv, person
    
    var index: Int {
        get {
            switch self {
            case .all:
                return 0
            case .movie:
                return 1
            case .tv:
                return 2
            case .person:
                return 3
            }
        }
    }
    
    static func caseAtIndex(_ index: Int) -> Trends? {
        switch index {
        case 0:
            return .all
        case 1:
            return .movie
        case 2:
            return .tv
        case 3:
            return .person
        default:
            return nil
        }
    }
    
    mutating func setIndex(_ newIndex: Int) {
        if let newCase = Trends.caseAtIndex(newIndex) {
            self = newCase
        }
    }
}
