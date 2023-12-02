//
//  Color.swift
//  TMDB Project
//
//  Created by yeoni on 2023/12/02.
//

import UIKit

enum Color: String {
    case background
    case content
    
    var color: UIColor {
        UIColor(named: self.rawValue)!
    }
}
