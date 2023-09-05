//
//  Realm+.swift
//  BOOKWARM Project
//
//  Created by yeoni on 2023/09/04.
//

import UIKit
import RealmSwift

extension UIViewController {
    func saveBookData(book: Document) {
        let realm = try! Realm()
        let record = BookTable(book: book)
        
        try! realm.write {
            realm.add(record)
            print("saved!!")
        }
    }
}

extension UICollectionViewCell {
    func saveBookData(book: BookTable) {
        let realm = try! Realm()
        let record = book
        
        try! realm.write {
            realm.add(record)
            print("saved!!")
        }
    }
}
