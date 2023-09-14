//
//  HomeViewController.swift
//  PhotoGram
//
//  Created by yeoni on 2023/08/31.
//

import UIKit



class HomeViewController: BaseViewController, HomeViewProtocol {
    
    var list: Photo = Photo(total: 0, total_pages: 0, results: [])
    
    let mainView = HomeView()
    
    override func loadView() {
        // class 내부에 선언해서 계속 인스턴스를 가지고 있는 게 아니라!! 함수 안에 넣어서 주기가 빨리 끝나도록 했음~~
        mainView.delegate = self
        self.view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self, #function)
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        APIService.shared.callRequest(query: "jack") { photo in
            
            guard let photo else {
                print("ALERT ERROR")
                return
            }
            
            print("API END")
            
            self.list = photo
            
            // UIUpdate만 main이 진행하도록!!
            self.mainView.collectionView.reloadData()
        }
        
    }
    
    deinit {
        print(self, #function)
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        print(indexPath)
        // 근데 문제!! 여기서 나가줄 경우에는 deinit이 안댐...
        // delegate를 연결하면 deinit이 안 뜨네?!?!?!?!?!
        // delegate 연결 안 해 줬을 때는 deinit 떳음 ...
        navigationController?.popViewController(animated: true)
    }
    
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(#function)
        return list.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#function)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        cell.imageView.backgroundColor = .systemBlue
        
        let thumbnail = list.results[indexPath.item].urls.thumb
        let url = URL(string: thumbnail)
        // 링크를 기반으로 이미지를 보여준다?? => 네트워크 통신!!
        
        // 동기 코드......
        // main이 혼자 일하고 있는 거임 ㅠㅠ 지금
        // 네트워크 통신이라고 하면 다른 알바생이 일할 수 있는 환경이 필요함!!
        
        DispatchQueue.global().async {
            
            let data = try! Data(contentsOf: url!)
            
            DispatchQueue.main.async {
                
                cell.imageView.image = UIImage(data: data)
                
            }
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        //        delegate?.didSelectItemAt(indexPath: indexPath)
    }
    
    
}


// AnyObject: 클래스에서만 프로토콜을 정의할 수 있도록 제약
protocol HomeViewProtocol: AnyObject {
    func didSelectItemAt(indexPath: IndexPath)
}
