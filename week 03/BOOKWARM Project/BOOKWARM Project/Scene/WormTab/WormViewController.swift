//
//  WormViewController.swift
//  BOOKWARM Project
//
//  Created by yeoni on 2023/09/04.
//

import UIKit
import SnapKit
import RealmSwift

class WormViewController: UIViewController {
   
    var record: Results<BookTable>! 
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
        let nib = UINib(nibName: MovieCollectionViewCell.identifier, bundle: nil)
        view.register(nib, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setConstraints()
        
        let realm = try! Realm()
        
        record = realm.objects(BookTable.self).sorted(byKeyPath: "title", ascending: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
    }
    
    func configureView() {
        view.backgroundColor = .systemBackground
        title = "Book"
        
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

extension WormViewController {
    private func setCollectionViewLayout() -> UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 6
        let width = UIScreen.main.bounds.width - (spacing * 3)
        
        layout.itemSize = CGSize(width: width / 2, height: width * 5 / 7)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing / 2
        
        return layout
    }
    
}


extension WormViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return record.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        
        cell.book = record[indexPath.item]
        cell.setupBookUI()
        cell.backView.backgroundColor = .black
        return cell
        
    }
    
}
