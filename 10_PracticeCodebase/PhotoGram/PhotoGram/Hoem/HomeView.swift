//
//  HomeView.swift
//  PhotoGram
//
//  Created by yeoni on 2023/08/31.
//

import UIKit

class HomeView: BaseView {
    
    lazy var collectionView = {
        // 플로우 레이아웃으로 잡을 경우에는 일케 잡아주면 댐
        // 근데 이거 UICollectionView() 이런 형식으로 잡아줘도 오류가 안 나서 헤맬 수 잇음 주의 !!
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout()) // O
        view.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "SearchCollectionViewCell")
//        view.dataSource = self
//        view.delegate = self
        return view
    }()
    
    weak var delegate: HomeViewProtocol?
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        let size = UIScreen.main.bounds.width - 40 // self.frame.width
        // self의 frame은 -40인 상태임
        layout.itemSize = CGSize(width: size / 3, height: size / 3)
        return layout
    }
    
    override func configureView() {
        addSubview(collectionView)
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


//extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource {
//    
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 100
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
//        cell.imageView.backgroundColor = .systemBlue
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(#function)
//        delegate?.didSelectItemAt(indexPath: indexPath)
//    }
//    
//    
//}
