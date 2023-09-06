//
//  Realm+.swift
//  BOOKWARM Project
//
//  Created by yeoni on 2023/09/04.
//

import UIKit
import RealmSwift

protocol BookTableRepositoryType: AnyObject {
    func fetch() -> Results<BookTable>
    func create(_ item: BookTable)
    func updateBook(id: ObjectId, liked: Bool, memo: String)
    func getFileURL()
    func checkSchemaVersion()
}



class BookTableRepository: BookTableRepositoryType {
    
    let realm = try! Realm()
    
    
    func fetch() -> RealmSwift.Results<BookTable> {
        let record = realm.objects(BookTable.self).sorted(byKeyPath: "title", ascending: false)
        return record
    }
    
    func create(_ item: BookTable) {
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print(error)
        }
    }
    
    func updateBook(id: ObjectId, liked: Bool, memo: String) {
        do {
            try realm.write{
                
                realm.create(BookTable.self, value: ["_id": id, "liked": liked, "memo": memo], update: .modified)
                
            }
        } catch {
            print("\(error)")
        }
    }
    
    func getFileURL() {
        print(realm.configuration.fileURL)
    }
    
    func checkSchemaVersion() {
        do {
            let version = try schemaVersionAtURL(realm.configuration.fileURL!)
            print("Schema Version: \(version)")
        } catch {
            print(error)
        }
    }
    
}
