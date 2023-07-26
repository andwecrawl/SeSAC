//
//  UserDefault.swift
//  EmoteDiary
//
//  Created by yeoni on 2023/07/26.
//

import Foundation

func resetUserDefault() {
    UserDefaults.standard.set(0 , forKey: "happy")
    UserDefaults.standard.set(0, forKey: "good")
    UserDefaults.standard.set(0, forKey: "soso")
    UserDefaults.standard.set(0, forKey: "notBad")
    UserDefaults.standard.set(0, forKey: "bad")
}

func saveUserDefault() {
    UserDefaults.standard.set(emoteValue[Emote.happy.tag]! , forKey: "happy")
    UserDefaults.standard.set(emoteValue[Emote.good.tag]!, forKey: "good")
    UserDefaults.standard.set(emoteValue[Emote.soso.tag]!, forKey: "soso")
    UserDefaults.standard.set(emoteValue[Emote.notBad.tag]!, forKey: "notBad")
    UserDefaults.standard.set(emoteValue[Emote.bad.tag]!, forKey: "bad")
}
