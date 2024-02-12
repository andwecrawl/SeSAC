//
//  TodoTable.swift
//  PhotoGramRealm
//
//  Created by yeoni on 2023/09/08.
//

import Foundation
import RealmSwift

class TodoTable: Object {
    // persisted: 현재 버전 램
    // dynamic: 이전 버전 램 (이전에 컬럼 생성 시 사용했던 접두어)
    
    // Primary Key를 기준으로 찾으면 index 속성이 있어서 특정 todoRecord를 이걸루 가져오게 댐
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var favorite: Bool
    
    // To many Realtionship
    // 이 친구는 배열의 형태이기 땜에 빈 배열의 형태로도 들어가게 댐
    // 데이터가 한 방향으로 흘러가게 댐 => 단방향!!
    // todoTable -> Detail을 세세하게 다 알고 있음
    @Persisted var detail: List<DetailTodoTable>
    
    // To One Relationship: EmbededObject
    // 엄격하게 이야기하면, 별도의 테이블이 detail처럼 생기지 않음 (별도의 테이블이 생성되는 형태 XXX)
    //  별도의 인스턴스로 구현!!\
    // EmbededObject는 꼭!! 옵셔널로 선언해 줘야 함
    @Persisted var memo: Memo?
    
    convenience init(title: String, favorite: Bool) {
        self.init()
        
        self.title = title
        self.favorite = favorite
    }
    
}


// 역관계!!
class DetailTodoTable: Object {
    // persisted: 현재 버전 램
    // dynamic: 이전 버전 램 (이전에 컬럼 생성 시 사용했던 접두어)
    
    // Primary Key를 기준으로 찾으면 index 속성이 있어서 특정 todoRecord를 이걸루 가져오게 댐
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var detail: String
    @Persisted var deadLine: Date
    
    // 원래 본질적인 프로퍼티는 누구야??
    // 얘는 단순한 연결고리라 컬럼이 하나로 늘어난 걸로 취급되지 않음
    // originProperty 안에는 origin table의 변수명을 입력!!
    @Persisted(originProperty: "detail") var mainTodo: LinkingObjects<TodoTable> // (단순한 연결고리)
    // 자식 같은 친구(todo)가 어디에 속해 있는지 알려달라고 하는 거잉!!
    // 역관계를 정의하는 거!!
    // todo.detail = Detail 과 연결된다고 보면 댐!!
    // 보통 역관계를 정의하여 내가 어떤 테이블에 속해있는지를 가시적으로 표현함!!
    
    convenience init(detail: String, deadLine: Date) {
        self.init()
        
        self.detail = detail
        self.deadLine = deadLine
    }
    
}


// 이 친구를 하나의 column 단위로 사용해 보려고 함
// 일대일 관계라고 함
// toOneRelationship
// 이 memo가 특정 컬럼에 들어갈 수 있는 상태로 만들어지게 됨
class Memo: EmbeddedObject {
    @Persisted var content: String
    @Persisted var date: Date
    
    // EmbededObject에서는 linkingObject를 잘 쓰지 않음!!
    
}
