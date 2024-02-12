//
//  SearchCollectionViewController.swift
//  OneLineDiary
//
//  Created by yeoni on 2023/07/31.
//

import UIKit

private let reuseIdentifier = "Cell"

class SearchCollectionViewController: UICollectionViewController {
    
    let searchBar = UISearchBar()
    
    let list = ["iOS", "iPad", "Android", "Watch", "사과", "사자", "호랑이"]
    var searchList: [String] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.placeholder = "검색어를 입력해 주세요"
        
        searchBar.showsCancelButton = true
        navigationItem.titleView = searchBar
        
        let nib = UINib(nibName: "SearchCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        
        setCollectionViewLayout()
        
        
    }


    
    
    func setCollectionViewLayout()  {
        // cell estimated size none으로 인터페이스 빌더에서 설정할 것!!
        // imageView로 올라갈 경우 자기 크기를 유지하려고 하니까... 인터페이스 빌드 컬렉션 뷰에 estimated size가 automatic(기본)
        
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        
        // 디바이스의 너비
        let width = UIScreen.main.bounds.width - (spacing * 4)
        // cell들이 가져갈 수 있는 넓이
        // 그림 그려보는 거 추천˜˜˜!!
        
        
        // layout은 class!! itemSize는 변수!!
        layout.itemSize = CGSize(width: width / 3, height: width / 3)
        
        
        // collectionView 좌우상하 여백 설정해 주기
        // collectionView의 여백과 inset을 주는 건 명백히 다름!!! 그 차이 이해하깅
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        // 사이 간격
        layout.minimumLineSpacing = spacing
        
        // 변경해 달라고 요청!
        collectionView.collectionViewLayout = layout
    }
    
    
    
    // 1. cell 갯수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchList.count
    }
    
    
    // 2. cell for item at (cell design)
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
        
        cell.backgroundColor = .green
        
        cell.contentLabel.text = searchList[indexPath.row]
        
        
        
        return cell
    }
    
    
    // 3.
    
    
    
}


extension SearchCollectionViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
        searchList.removeAll()
        
        for item in list {
            if item.contains(searchBar.text!) && !searchList.contains(item) {
                searchList.append(item)
            }
        }
        
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchList = []
        searchBar.text = ""
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchList = []
    }
    
}
