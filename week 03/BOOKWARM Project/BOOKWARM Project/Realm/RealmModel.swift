//
//  Realm.swift
//  BOOKWARM Project
//
//  Created by yeoni on 2023/09/04.
//

import Foundation
import RealmSwift

class BookTable: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String
    @Persisted var contents: String
    @Persisted var price: Int
    @Persisted var authors: String
    @Persisted var dateTime: String
    @Persisted var thumbnail: String?
    @Persisted var url: String
    @Persisted var liked: Bool
    
    convenience init(title: String, contents: String, price: Int, authors: String, dateTime: String, thumbnail: String?, url: String, liked: Bool) {
        self.init()
        self.title = title
        self.contents = contents
        self.price = price
        self.authors = authors
        self.dateTime = dateTime
        self.thumbnail = thumbnail
        self.url = url
        self.liked = liked
    }
    
    convenience init(book: Document) {
        self.init(title: book.title, contents: book.contents, price: book.price, authors: book.authorsDescriptions, dateTime: book.datetime, thumbnail: book.thumbnail, url: book.url, liked: false)
    }
}

/*
 Document(authors: ["市川拓司／著"], contents: "", datetime: "2017-07-14T00:00:00.000+09:00", isbn: "4093864713 9784093864718", price: 19750, publisher: "小學館", salePrice: 18490, status: Optional("정상판매"), thumbnail: Optional("https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F3499882%3Ftimestamp%3D20230315162037"), title: "MM", translators: [], url: "https://search.daum.net/search?w=bookpage&bookId=3499882&q=MM")
 */
