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
    @Persisted var publisher: String
    @Persisted var thumbnail: String?
    @Persisted var url: String
    @Persisted var liked: Bool
    @Persisted var memo: String
    
    convenience init(title: String, contents: String, price: Int, authors: String, publisher: String, thumbnail: String?, url: String, liked: Bool) {
        self.init()
        self.title = title
        self.contents = contents
        self.price = price
        self.authors = authors
        self.publisher = publisher
        self.thumbnail = thumbnail
        self.url = url
        self.liked = liked
    }
    
    convenience init(book: Document) {
        self.init(title: book.title, contents: book.contents, price: book.price, authors: book.authorsDescriptions, publisher: book.publisher, thumbnail: book.thumbnail, url: book.url, liked: false)
    }
}

