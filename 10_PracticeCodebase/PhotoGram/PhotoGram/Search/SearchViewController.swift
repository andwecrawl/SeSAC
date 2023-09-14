//
//  SearchViewController.swift
//  PhotoGram
//
//  Created by yeoni on 2023/08/28.
//

import UIKit

class SearchViewController: BaseViewController {

    let mainView = SearchView()
    
    var imageList = Search(total: 0, totalPages: 0, results: [])
    var images: [UIImage?] = [] {
        didSet {
            DispatchQueue.main.async {
                self.mainView.collectionView.reloadData()
            }
        }
    }
    
    var delegate: PassImageDelegate?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @objc func recommandKeywordNotificationObserver(notification: NSNotification) {
        print(#function)
    }
    
    override func configureView() {
        super.configureView()
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.searchBar.becomeFirstResponder()
        mainView.searchBar.delegate = self
    }
    
}



extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // 더 이상 사용자의 포커스가 해당 뷰에 없다는 걸 명시적으로 말해주는 거임!!
        // endEditing이랑 비슷함
        mainView.searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        // 데이터 불러오고 셀 다시 초기화하는 게 필요함
        guard let text = searchBar.text else { return }
        APIHelper.shared.callRequest(query: text) { data in
            guard let data else {
                self.giveAlert(title: "데이터를 가져올 수 없습니다.", message: "다시 시도해 주세요! ㅠㅠ")
                return
            }
            self.imageList = data
            let result = self.imageList.results
            
            for element in result {
                let thumb = element.urls.thumb
                self.getPic(str: thumb) { image in
                    if let image {
                        self.images.append(image)
                    } else {
                        print("변환안댐..")
                    }
                }
            }
        }
        
    }
}


extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        if let image = images[indexPath.item] {
            cell.imageView.image = image
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fullImage = imageList.results[indexPath.item].urls.full
        getPic(str: fullImage) { image in
            guard let image else { return }
            self.delegate?.receiveData(Image: image)
        }
        navigationController?.popViewController(animated: true)
    }
}

extension SearchViewController {
    
    func getPic(str: String, completionHandler: @escaping (UIImage?) -> ()) {
        guard let url = URL(string: str) else { return }
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                completionHandler(image)
            } catch {
                print("error")
            }
        }
    }
    
    func giveAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: "okay", style: .default, handler: nil)
        alert.addAction(okay)
        present(alert, animated: true)
    }
}
