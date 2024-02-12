//
//  TodoViewController.swift
//  PhotoGramRealm
//
//  Created by yeoni on 2023/09/08.
//

import UIKit
import RealmSwift

class TodoViewController: BaseViewController {
    
    let realm = try! Realm()
    
    var list: Results<DetailTodoTable>!
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list = realm.objects(DetailTodoTable.self)
        print(realm.configuration.fileURL)
//        print(realm.objects(TodoTable.self))
        print(list)
        print(realm.objects(DetailTodoTable.self))

    }
    
    override func configure() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 40
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "todoCell")
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
    
    
    func viewDetail() {
        
        
        let data = TodoTable(title: "영화 보기", favorite: false)
        
        let memo = Memo()
        memo.content = "주말에 눈물 흘리면서 리캡 하기"
        memo.date = Date()
        
        data.memo = memo
        
        try! realm.write {
            realm.add(data)
        }
        
        
        
//        let data = TodoTable(title: "장보기", favorite: true)
//
//        let detail1 = DetailTodoTable(detail: "양파", deadLine: Date())
//        let detail2 = DetailTodoTable(detail: "파인애플", deadLine: Date())
//        let detail3 = DetailTodoTable(detail: "고구마", deadLine: Date())
//
////        // 이렇게 미리 구성 후 추가해도 ㄱㅊ
////        data.detail.append(detail1)
////        data.detail.append(detail2)
////        data.detail.append(detail3)
//
//        try! realm.write({
//            realm.add(data)
//            data.detail.append(detail1)
//            data.detail.append(detail2)
//            data.detail.append(detail3)
//        })
    }
    
    
    func createDetail() {
        
        createTodo()
        
        let main = realm.objects(TodoTable.self).where {
            $0.title == "장보기"
        }.first!
        
        for index in 1...10 {
            let detailTodo = DetailTodoTable(detail: "세부 할 일 \(index)", deadLine: Date())
            
            try! realm.write {
//                realm.add(detailTodo)
                main.detail.append(detailTodo)
            }
        }
    }
    
    func createTodo() {
        
        for element in ["장보기", "영화보기", "리캡하기", "좋아요 구현하기", "잠자기"] {
            
            let data = TodoTable(title: element, favorite: false)
            
            try! realm.write {
                realm.add(data)
            }
        }
        
    }
    
}


extension TodoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell")!
        let content = list[indexPath.row]
        cell.textLabel?.text = "\(content.detail) in \(content.mainTodo.first?.title ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let data = list[indexPath.row]
//
//        try! realm.write {
//            realm.delete(data.detail)
//            realm.delete(data)
//        }
        
//        tableView.reloadData()
    }
    
    
    
    
}
