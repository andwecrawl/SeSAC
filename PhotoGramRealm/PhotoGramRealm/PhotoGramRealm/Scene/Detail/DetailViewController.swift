//
//  DetailViewController.swift
//  PhotoGramRealm
//
//  Created by yeoni on 2023/09/05.
//

import UIKit
import RealmSwift

class DetailViewController: BaseViewController {
    
    var data: DiaryTable?
    let realm = try! Realm()
    
    
    let titleTextField: WriteTextField = {
        let view = WriteTextField()
        view.placeholder = "제목을 입력해주세요"
        view.textColor = .lightGray
        return view
    }()
    
    let contentTextField: WriteTextField = {
        let view = WriteTextField()
        view.placeholder = "날짜를 입력해주세요"
        view.textColor = .lightGray
        return view
    }()
    
    let repository = DiaryTableRepository()
    
    
    override func configure() {
        super.configure()
        
        view.addSubview(titleTextField)
        view.addSubview(contentTextField)
//        print(data?.title)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "edit", style: .plain, target: self, action: #selector(editButtonClicked))
        
        guard let data = data else { return }
        
        titleTextField.text = data.title
        contentTextField.text = data.content
        
    }
    
    @objc func editButtonClicked() {
        
        guard let data = data else { return }
        
        // Realm Update
            // 수정을 할 때 PK가 자주 사용댐..
            // 절대 변경이되지 않더라도 기준점 Id로 PK를 가지고 있는 게 좋음
            // ["수정하자 하는 record":
        
        repository.updateItem(id: data._id, title: titleTextField.text!, contents: contentTextField.text!)
        
        /*
        let item = DiaryTable(value: ["_id": data._id, "title": titleTextField.text!, "contents": contentTextField.text!])
        
        do {
            try realm.write {
                // 특정 record에 있는 걸 하나씩 확인해 주는 거임
                // try 구문 안에 있는 건 transaction 때문!!
//                realm.add(item, update: .modified)
                realm.create(DiaryTable.self, value: ["_id": data._id, "title": titleTextField.text!, "contents": contentTextField.text!], update: .modified)
            }
        } catch {
            // NSlog로 뭐 기록을 남기거나 집계를 하거나 한다면 좋을 것 같음~~
            // 좀 귀찮더라도 do-catch문으로 담아두면 좋을 것 같당 ㅇㅂㅇ
            print("\(error)")
        }
         */
        
        navigationController?.popViewController(animated: true)
    }
    
    
    override func setConstraints() {
        titleTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.center.equalTo(view)
        }
        
        contentTextField.snp.makeConstraints { make in
            make.size.equalTo(titleTextField)
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(60)
        }
    }
    
    
    
}

