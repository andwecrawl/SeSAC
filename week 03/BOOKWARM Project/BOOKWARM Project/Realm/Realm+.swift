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
        
        if let thumb = record.thumbnail {
            APIHelper.shared.getImage(path: thumb) { image in
                guard let image else { return }
                FileManagerHelper.shared.doSomethingToDocument(status: .save, id: record._id, image: image) { image in
                    guard image != nil else {
                        print("error!")
                        return
                    }
                }
            }
        }
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
