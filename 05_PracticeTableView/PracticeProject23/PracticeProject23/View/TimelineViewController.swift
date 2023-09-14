//
//  TimelineViewController.swift
//  PracticeProject23
//
//  Created by yeoni on 2023/08/02.
//

import UIKit

/*
 1. 프로토콜(ex. 부하직원): UICollectionViewDelegate, UICollectionViewDataSource
 2. 컬렉션뷰와 부하직원을 연결시켜주는 작업이 필요함
    delegate = self (type으로서 프로토콜 사용!!)
 3. 컬렉션뷰 아웃렛 선언 필요
 */


class TimelineViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var todayCollectionView: UICollectionView!
    
    @IBOutlet weak var bestCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        todayCollectionView.delegate = self
        todayCollectionView.dataSource = self
        
        bestCollectionView.delegate = self
        bestCollectionView.dataSource = self
        
        let nib = UINib(nibName: "SearchCollectionViewCell", bundle: nil)
        todayCollectionView.register(nib, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        bestCollectionView.register(nib, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        
        configureCollectionViewLayout()
        configureBestCollectionViewLayout()
        
    }
    
    func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 180)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        todayCollectionView.collectionViewLayout = layout
    }
    
    
    func configureBestCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 180)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        bestCollectionView.collectionViewLayout = layout
        
        // 페이지 효과를 줌... 짱이당
        bestCollectionView.isPagingEnabled = true
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return collectionView == todayCollectionView ? 3 : 10
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath)
        
        if collectionView == todayCollectionView {
//            cell.resultLabel.text = "today: \(indexPath.row)"
            cell.backgroundColor = .yellow
            
        } else {
//            cell.resultLabel.text = "best: \(indexPath.row)"
            cell.backgroundColor = .green
        }
        
        return cell
    }
    

}
