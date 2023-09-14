//
//  SearchView.swift
//  PhotoGram
//
//  Created by yeoni on 2023/08/28.
//

import UIKit

class SearchView: BaseView {
    
    let searchBar = {
        let view = UISearchBar()
        view.placeholder = "검색어를 입력해 주세요"
        return view
    }()
    
    // lazy var가 아니면 파라미터가 없다고 할 수 있을 거잉...
    // 잉? 레이아웃 넣어줬는데 왜?! 라고 한다면
    // 초기화가 되는 당시에 UICollectionView도 code로 초기화하게 대면 레이아웃에 대한 초기화가 필요함
    lazy var collectionView = {
        // 플로우 레이아웃으로 잡을 경우에는 일케 잡아주면 댐
        // 근데 이거 UICollectionView() 이런 형식으로 잡아줘도 오류가 안 나서 헤맬 수 잇음 주의 !!
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout()) // O
        view.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        view.collectionViewLayout = collectionViewLayout()
        return view
    }()
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        let size = UIScreen.main.bounds.width - 40
        // self의 frame은 -40인 상태임
        layout.itemSize = CGSize(width: size / 4, height: size / 4)
        return layout
    }
    
    override func configureView() {
        addSubview(searchBar)
        addSubview(collectionView)
    }
    
    override func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom)
        }
    }
}
