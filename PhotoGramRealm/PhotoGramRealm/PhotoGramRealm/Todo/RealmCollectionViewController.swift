//
//  RealmCollectionViewController.swift
//  PhotoGramRealm
//
//  Created by yeoni on 2023/09/14.
//

import UIKit
import SnapKit
import RealmSwift

class RealmCollectionViewController: BaseViewController {
    
    let realm = try! Realm()
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    var list: Results<TodoTable>!
    
    // 얘는 누구랑 대응? => CollectionViewRegister 대신!!
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, TodoTable>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list = realm.objects(TodoTable.self)
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        // itemIdentifier = list[indexPath.item]
        // cell for item at 에서 data로 연결해 줬기 땜에 itemIdentifier에 들어가는 거임!!
        cellRegistration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.image = itemIdentifier.favorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
            content.text = itemIdentifier.title
            content.secondaryText = "\(itemIdentifier.detail.count)개의 세부 할 일"
            cell.contentConfiguration = content
            
        })
    }
    
    static func layout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    
}


extension RealmCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 하나의 셀에 차지하려고 하는 특정 타입
        let data = list[indexPath.item]
        
        // 타입이 안 맞는 형태야~~
        // string이 아니라 realm을 넣고 있어서 그럼!!
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: data)
        return cell
    }
    
    
    
}
