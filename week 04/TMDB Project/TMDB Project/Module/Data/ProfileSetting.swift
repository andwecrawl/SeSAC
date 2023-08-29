//
//  ProfileSetting.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/29.
//

import UIKit

class Profile {
    
    var name: String
    var username: String
    var pronouns: String
    var bio: String
    var link: String
    var gender: Gender
    
    enum Gender: String {
        case male
        case female
        case nonBinary
        case notTosay = "I prefer not to say"
        case none
    }
    
    fileprivate init(name: String, username: String, pronouns: String, bio: String, link: String, gender: Gender) {
        self.name = name
        self.username = username
        self.pronouns = pronouns
        self.bio = bio
        self.link = link
        self.gender = gender
    }
}

//let user = Profile(name: "", username: "", pronouns: "", bio: "", link: "", gender: .none)


enum SettingName: String {
    case Name
    case Username
    case Pronouns
    case Bio
    case Link
    case Gender
}

struct Setting {
    var name: SettingName
    var user: String
}

struct SettingList {
    var image: UIImage?
    var user = [
        Setting(name: .Name, user: ""),
        Setting(name: .Username, user: ""),
        Setting(name: .Pronouns, user: ""),
        Setting(name: .Bio, user: ""),
        Setting(name: .Link, user: ""),
        Setting(name: .Gender, user: "")
    ]
}
