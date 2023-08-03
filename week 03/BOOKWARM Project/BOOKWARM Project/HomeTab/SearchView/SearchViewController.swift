//
//  SearchViewController.swift
//  BOOKWARM Project
//
//  Created by yeoni on 2023/08/03.
//

import UIKit

class SearchViewController: UIViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var searchTableView: UITableView!
    
    
    let list = MovieList().list
    var searchList: [Movie] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "검색"
        addLeftBarItem()
        
        searchBar.delegate = self
        searchTableView.dataSource = self
        searchTableView.delegate = self
        
        let nib = UINib(nibName: "SearchTableViewCell", bundle: nil)
        searchTableView.register(nib, forCellReuseIdentifier: "SearchTableViewCell")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
            tapGesture.cancelsTouchesInView = false
            view.addGestureRecognizer(tapGesture)
        
        designSearchBar()
    }
    
    @objc func endEditing() {
        searchBar.endEditing(true)
    }
    
    func addLeftBarItem() {
        let xMark = UIImage(systemName: "xmark")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: xMark, style: .plain, target: self, action: #selector(closeButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .black
        print("hello?")
    }
    
    @objc func closeButtonTapped() {
        dismiss(animated: true)
    }

}


// searchBar
extension SearchViewController: UISearchBarDelegate {
    
    func designSearchBar() {
        searchBar.placeholder = "검색어를 입력하세요"
        searchBar.setValue("취소", forKey: "cancelButtonText")
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchList.removeAll()
        
        guard let text = searchBar.text else { return }
        
        for movie in list {
            if movie.name.contains(text) || movie.genre.rawValue.contains(text) {
                searchList.append(movie)
            }
        }
        
        searchTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchList = []
    }
    
}


// tableView
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as? SearchTableViewCell else {
            return UITableViewCell()
        }
        
        if searchList.isEmpty { return UITableViewCell() }
        
        cell.movie = searchList[indexPath.row]
        cell.configurateCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        
        vc.movie = searchList[indexPath.row]
        vc.hidden = false
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .formSheet
        
        present(vc, animated: true)
        
        tableView.keyboardDismissMode = .onDrag
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
}
