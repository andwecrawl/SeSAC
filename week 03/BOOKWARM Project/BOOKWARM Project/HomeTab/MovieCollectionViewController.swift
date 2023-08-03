//
//  MovieCollectionViewController.swift
//  BOOKWARM Project
//
//  Created by yeoni on 2023/07/31.
//

import UIKit

private let reuseIdentifier = "Cell"

class MovieCollectionViewController: UICollectionViewController, UISearchBarDelegate {

    
    var list = MovieList().list {
        didSet {
            collectionView.reloadData()
        }
    }
    var searchList: [Movie] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       let nib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        
        setCollectionViewLayout()
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    
    // 코드로 화면 옮기기
    @IBAction func searchButtonTapped(_ sender: UIBarButtonItem) {
       
        // 누르면 숨겨져 있던 searchBar 보이는 걸로 수정... 하고 싶었는데 실패 ^_^
        // reusableCell 어케 쓰는 거임???
        
        
        // 스토리보드 파일 찾기
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        // 스토리보드 파일 내 뷰 컨트롤러 찾기
        guard let vc = sb.instantiateViewController(identifier: "SearchViewController") as? SearchViewController else {
            return
        }
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
        
        
    }
    

    
    func setCollectionViewLayout() {
        
        // CollectionViewLayout 잡기
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 6
        
        // screen 화면에서 여백을 뺀 Cell 전체의 길이
        let width = UIScreen.main.bounds.width - (spacing * 3)
        
        // Cell 하나의 가로 / 세로
        layout.itemSize = CGSize(width: width / 2, height: width * 5 / 7)
        
        // 위아래 여백
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        // Cell 사이 여백
        layout.minimumInteritemSpacing = spacing / 2
        
        // layout 적용
        collectionView.collectionViewLayout = layout
    }
    
    
    // cell의 갯수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    
    // cell design
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
         
        let movie = list[indexPath.row]
        cell.movie = movie
        cell.fillCell()
       
        let row = indexPath.row
        cell.likedButton.tag = row
        cell.likedButton.addTarget(self, action: #selector(likedButtonTapped), for: .touchUpInside)
        return cell
        
    }
    
    @objc func likedButtonTapped(_ sender: UIButton) {
        list[sender.tag].liked.toggle()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = sb.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else {
            return
        }
        
        vc.movie = list[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // 아니 이거 왜 안 댐?????
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) ->
            UICollectionReusableView {
                print("hi")
         switch kind {
         case UICollectionView.elementKindSectionHeader:
           // 2
           let headerView = collectionView.dequeueReusableSupplementaryView(
             ofKind: kind,
             withReuseIdentifier: "\(SearchCollectionReusableView.self)",
             for: indexPath)

           // 3
           guard let typedHeaderView = headerView as? SearchCollectionReusableView
           else { return headerView }

             typedHeaderView.searchBar.placeholder = "단어를 입력하세요!"
           return typedHeaderView
         default:
           // 5
           assert(false, "Invalid element type")
         }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        
        for element in list {
            if element.name.contains(text) || element.genre.rawValue.contains(text) {
                searchList.append(element)
            }
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchList = []
        searchBar.text = ""
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchList = []
    }

}
