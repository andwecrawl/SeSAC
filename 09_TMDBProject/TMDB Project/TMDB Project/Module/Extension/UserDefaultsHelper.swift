//
//  UserDefaultsHelper.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/27.
//

import Foundation

class UserDefaultsHelper {
    
    static let shared = UserDefaultsHelper()
    
    private init() { }
    
    let userDefaults = UserDefaults.standard
    
    var haveBeenBefore: Bool {
        get {
            return userDefaults.bool(forKey: "haveBeenBefore")
        }
        set {
            userDefaults.set(newValue, forKey: "haveBeenBefore")
        }
    }
    
    
}
