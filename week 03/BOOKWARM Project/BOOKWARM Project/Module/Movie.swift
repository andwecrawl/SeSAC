//
//  Movie.swift
//  BOOKWARM Project
//
//  Created by yeoni on 2023/08/01.
//

import UIKit



struct Movie {
    var name: String
    var rate: Float
    var runningTime: String
    var genre: Genre
    var plot: String
    var liked: Bool
    var color: UIColor
    
    var description: String {
        return "\(genre) · \(runningTime) · \(rate)"
    }
    var exploreDescription: String {
        return "\(genre) · \(runningTime)"
    }
    
    enum Genre: String {
        case animation, SF, romance, action, fantasy, comedy, thiller
    }
}
