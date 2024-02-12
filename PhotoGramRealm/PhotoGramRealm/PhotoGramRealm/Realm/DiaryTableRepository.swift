//
//  DiaryTableRepository.swift
//  PhotoGramRealm
//
//  Created by yeoni on 2023/09/06.
//

import Foundation
import RealmSwift

// respository Pattern
    // 사용자가 데이터를 저장하고 사용할 때 어떤 걸 쓰고 있는지 모르는? 거
    // 목적에 맞게만 만들면 되고 특정 패턴에 치중될 필요는 읍다


// repository의 경우 protocol로 추상화하게 댐
protocol DiaryTableRepositoryType: AnyObject {
    func fetch() -> Results<DiaryTable>
    func fetchFilter() -> Results<DiaryTable>
    func create(_ item: DiaryTable)
}

class DiaryTableRepository: DiaryTableRepositoryType {
    
    private let realm = try! Realm()
    
    // 다른 파일에서 쓸 일 없고, 클래스 안에서만 쓸 수 있음 => 오버라이딩 불가능
    private func a() {
        
    }
    
    // read == fetch (보통 일케 말함)
    func fetch() -> Results<DiaryTable> {
        let data = realm.objects(DiaryTable.self).sorted(byKeyPath: "date", ascending: true)
        return data
    }
    
    func fetchFilter() -> Results<DiaryTable> {
        // 만약에 정렬과 필터를 동시에 구현한다면 필터를 먼저 한 이후에 정렬을 해야 할 거임!!
        let result = realm.objects(DiaryTable.self).where {
                  // 1. 대소문자 구별 없음 => caseInsensitive
            $0.title.contains("제목", options: .caseInsensitive)
        }
        return result
    }
    
    func create(_ item: DiaryTable) {
        
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print(error)
        }
        
    }
    
    func updateItem(id: ObjectId, title: String, contents: String) {
        do {
            try realm.write {
                
                realm.create(DiaryTable.self, value: ["_id": id, "title": title, "contents": contents], update: .modified)
                
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
