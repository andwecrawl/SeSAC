//
//  String+.swift
//  SACdyBuddy
//
//  Created by yeoni on 2023/11/10.
//

import Foundation


enum RegexType: String {
    case email = #"^([a-zA-Z0-9._-])+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,20}$"#
    case password = #"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{6,}$"#
}
