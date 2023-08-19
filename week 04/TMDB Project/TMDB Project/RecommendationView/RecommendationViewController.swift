//
//  RecommendationViewController.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/19.
//

import UIKit

class RecommendationViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchController()
        // Do any additional setup after loading the view.
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
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
    
}
