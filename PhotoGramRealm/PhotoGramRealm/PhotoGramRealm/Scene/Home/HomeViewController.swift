//
//  HomeViewController.swift
//  PhotoGramRealm
//
//  Created by jack on 2023/09/03.
//

import UIKit
import SnapKit
import RealmSwift

class HomeViewController: BaseViewController {
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 100
        view.delegate = self
        view.dataSource = self
        view.register(PhotoListTableViewCell.self, forCellReuseIdentifier: PhotoListTableViewCell.reuseIdentifier)
        view.backgroundColor = .black
        return view
    }()
    
    // 여기 무조건 데이터가 들어올 거야!!
    var tasks: Results<DiaryTable>!
    
    let repository = DiaryTableRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        repository.getFileURL()
        repository.checkSchemaVersion()
        // Realm Read
        // 이 친구가 바뀌면 매번 스스로 그걸 알고 데이터를 바꿔주기 땜에 관찰하거나 매번 바뀌었는지 확인할 필요가 없음!!
        // 그냥 뷰에 대한 갱신만 처리해 놓으면 데이터가 어떻게 바뀌는지는 신경쓰지 않아도 댐
            // realm에 한해서는 ㄱㅊ
//        let realm = try! Realm()
            // Results<DiaryTable> type
                // realm에서 만들어지는 타입으로 실시간으로 반영댐!!
        tasks = repository.fetch()
        
        
        print(tasks)
//        print(realm.configuration.fileURL)
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        
    }
    
    
    override func configure() {
        view.addSubview(tableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonClicked))
        
        let sortButton = UIBarButtonItem(title: "정렬", style: .plain, target: self, action: #selector(sortButtonClicked))
        let filterButton = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(filterButtonClicked))
        let backupButton = UIBarButtonItem(title: "백업", style: .plain, target: self, action: #selector(backupButtonClicked))
        navigationItem.leftBarButtonItems = [sortButton, filterButton, backupButton]
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func plusButtonClicked() {
        navigationController?.pushViewController(AddViewController(), animated: true)
    }
    
    @objc func backupButtonClicked() {
        navigationController?.pushViewController(BackupViewController(), animated: true)
    }
    
    
    @objc func sortButtonClicked() {
        
    }
    
    @objc func filterButtonClicked() {
        
        tasks = repository.fetchFilter()
        
        tableView.reloadData()
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoListTableViewCell.reuseIdentifier) as? PhotoListTableViewCell else { return UITableViewCell() }
        
        let data = tasks[indexPath.row]
        cell.titleLabel.text = data.title
        cell.contentLabel.text = data.content
        cell.dateLabel.text = "\(data.date)"
        cell.diaryImageView.image = loadImageFromDocument(fileName: "neenee_\(data._id).jpg")
        
        // let value = URL(string: data.diaryPhotoURL ?? "")
//        if let url = URL(string: data.diaryPhotoURL ?? "") {
//
//            // String -> URL (유효한 URL이라면?)
//            // -> Data -> UIImage!!
//            // 1. 셀 서버 통신 용량이 크다면 로드가 오래 걸릴 수 있음
//            // 2. 이미지를 미리 UIImage 형식으로 반환하고 셀에서 바로 UIImage를 보여주자1!
//            // 재사용 메커니즘을 효율적으로 사용하지 못할 수도 있고, UIImage 배열 구성 자체가 오래걸릴 수 있음......
//            // 답이 없는 곳에서 기준을 만
//            DispatchQueue.global().async {
//                if let data = try? Data(contentsOf: url) {
//
//                    DispatchQueue.main.async {
//                        cell.diaryImageView.image = UIImage(data: data)
//                    }
//
//                }
//            }
//        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        // Realm Delete
//        // 셀 선택했을 때 바로 제거가 되게끔 구성!!
//
//        let data = tasks[indexPath.row]
//
//        // 경로에 잇는 해당 파일 삭제!!!
//        removeImageFromDocument(fileName: "neenee_\(data._id).jpg")
//
//        // transaction에 의해서 try 구문 내에서 CRUD 구문을 써줘야 함
//        try! realm.write {
//            realm.delete(data)
//        }
//
//        tableView.reloadData()
        
        let vc = DetailViewController()
        vc.data = tasks[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let liked = UIContextualAction(style: .normal, title: "") { action, view, completionHandler in
            print("조아요 선택")
        }
        let cancel = UIContextualAction(style: .destructive, title: "") { action, view, completionHandler in
            print("시러요 선택")
        }
        
        liked.backgroundColor = .orange
        liked.image = UIImage(systemName: "hand.thumbsup.fill")
        // like.image = tasks[indexPath.row].diaryLike ? UIImage(systemName: "star.fill") : UIIImage(systemName: "star")
        
        cancel.image = UIImage(systemName: "hand.thumbsdown.fill")
        
        return UISwipeActionsConfiguration(actions: [liked, cancel])
        
        
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let liked = UIContextualAction(style: .normal, title: "") { action, view, completionHandler in
            print("조아요 선택")
        }
        let cancel = UIContextualAction(style: .destructive, title: "") { action, view, completionHandler in
            print("시러요 선택")
        }
        
        liked.backgroundColor = .orange
        liked.image = UIImage(systemName: "hand.thumbsup.fill")
        // like.image = tasks[indexPath.row].diaryLike ? UIImage(systemName: "star.fill") : UIIImage(systemName: "star")
        
        cancel.image = UIImage(systemName: "hand.thumbsdown.fill")
        
        return UISwipeActionsConfiguration(actions: [liked, cancel])
        
    }
}
