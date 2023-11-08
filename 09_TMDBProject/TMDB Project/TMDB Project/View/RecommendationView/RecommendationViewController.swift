//
//  RecommendationViewController.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/19.
//

import UIKit

class RecommendationViewController: UIViewController {

    @IBOutlet weak var recommendationCollectionView: UICollectionView!
    
    var movies: [Result] = [] {
        didSet {
            recommendationCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        title = "Recommendation"
        
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
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "좋아하는 영화 제목을 입력해 주세요!"
        searchController.hidesNavigationBarDuringPresentation = false
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "Recommendation"
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    
    


}

extension RecommendationViewController: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            giveAlert(title: "좋아하는 영화를 입력해 주세요!", message: "좋아하시는 영화를 기반으로 재미있는 영화를 추천해 드릴게요!")
            return
        }
        
        TMDBManager.shared.callSearchRequest(query: text) { movies in
            if movies.isEmpty {
                self.giveAlert(title: "추천해드릴 영화가 없어요!", message: "")
            }
            self.movies = movies
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        movies = []
    }
    
}


extension RecommendationViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // 이외에도 레이아웃 설정하는 게 필요함!!
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendationCollectionViewCell.identifier, for: indexPath) as? RecommendationCollectionViewCell else { return UICollectionViewCell() }
        
        
        cell.posterPath = movies[indexPath.row].posterPath
        cell.configureCell()
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: DetailTableViewController.identifier) as? DetailTableViewController else { return }
        vc.media = movies[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
        collectionView.reloadItems(at: [indexPath])
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



extension RecommendationViewController {
    
    func callRequest() {
        
        
        
        
    }
    
    
}
