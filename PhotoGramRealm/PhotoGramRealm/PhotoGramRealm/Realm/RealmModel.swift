//
//  RealmModel.swift
//  PhotoGramRealm
//
//  Created by yeoni on 2023/09/04.
//

import Foundation
import RealmSwift


class DiaryTable: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String // 일기 제목(필수)
    @Persisted var date: Date // 일기 날짜(필수)
    @Persisted var content: String?
    @Persisted var photo: String?
    @Persisted var liked: Bool // 즐겨찾기 기능(필수)
//    @Persisted var pinned: Bool
    @Persisted var diarySummary: String
    
    convenience init(title: String, date: Date, content: String? = nil, photoURL: String? = nil) {
        self.init()
        
        self.title = title
        self.date = date
        self.content = content
        self.photo = photoURL
        self.liked = true
        self.diarySummary = "제목은 '\(title)'이고, 내용은 '\(content ?? "")'입니당"
        
    }
}

