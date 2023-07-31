//
//  MovieCollectionViewController.swift
//  BOOKWARM Project
//
//  Created by yeoni on 2023/07/31.
//

import UIKit

private let reuseIdentifier = "Cell"

class MovieCollectionViewController: UICollectionViewController {

    
    let list = MovieList().list
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       let nib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        
        setCollectionViewLayout()
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    
    // 코드로 화면 옮기기
    @IBAction func searchButtonTapped(_ sender: UIBarButtonItem) {
        
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
        let spacing: CGFloat = 15
        
        // screen 화면에서 여백을 뺀 Cell 전체의 길이
        let width = UIScreen.main.bounds.width - (spacing * 3)
        
        // Cell 하나의 가로 / 세로
        layout.itemSize = CGSize(width: width / 2, height: width / 4 * 3)
        
        // 위아래 여백
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        // Cell 사이 여백
        layout.minimumInteritemSpacing = spacing
        
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
        cell.designCell()
        
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = sb.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else {
            return
        }
        
        vc.movieName = list[indexPath.row].name
        
        navigationController?.pushViewController(vc, animated: true)
    }
    

}
