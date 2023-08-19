//
//  RecommendationViewController.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/19.
//

import UIKit

class RecommendationViewController: UIViewController {

    @IBOutlet weak var recommendationCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        configureCollectionViewLayout()
        setupSearchController()
        
    }
    
    func setupCollectionView() {
        recommendationCollectionView.dataSource = self
        recommendationCollectionView.delegate = self
        
        let nib = UINib(nibName: RecommendationCollectionViewCell.identifier, bundle: nil)
        recommendationCollectionView.register(nib, forCellWithReuseIdentifier: RecommendationCollectionViewCell.identifier)
    }
    
    func setupSearchController() {
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "좋아하는 영화 제목을 입력해 주세요!"
        searchController.hidesNavigationBarDuringPresentation = false
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "Recommendation"
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    
    


}


extension RecommendationViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // 이외에도 레이아웃 설정하는 게 필요함!!
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendationCollectionViewCell.identifier, for: indexPath) as? RecommendationCollectionViewCell else { return UICollectionViewCell() }
        
        cell.posterImageView.image = UIImage(named: "testImage")
        
        return cell
    }
    
    func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let space: CGFloat = 12
        
        // 여백을 제외한 content 전체의 가로 길이
        // 이런 식으로 가로를 잡아주면 각 핸드폰의 가로 길이를 바탕으로 Content의 가로를 잡아주므로 확장성이 좋아짐!
        let width = UIScreen.main.bounds.width - (space * 4)
        
        // itemSize를 여백에 맞춰 만들어 주기
        layout.itemSize = CGSize(width: (width / 3), height: (width / 3) * 1.23)
        
        // 위아래 양옆 여백
        layout.sectionInset = UIEdgeInsets(top: 0, left: space, bottom: 4, right: space)
        
        // 사이 여백
        layout.minimumLineSpacing = space
        layout.minimumInteritemSpacing = space
        layout.scrollDirection = .vertical

        recommendationCollectionView.collectionViewLayout = layout
    }
    
    
    
}
