//
//  MoreViewController.swift
//  BOOKWARM Project
//
//  Created by yeoni on 2023/08/08.
//

import UIKit
import Alamofire
import Kingfisher
import RealmSwift

class MoreViewController: UIViewController {
    
    let searchBar = UISearchBar()
    
    @IBOutlet weak var searchTableView: UITableView!
    
    var isEnd: Bool = false
    var bookList: [Document] = [] {
        didSet {
            searchTableView.reloadData()
        }
    }
    var page: Int = 1
    var queryText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInit()
    }
    
    func setInit() {
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchTableView.prefetchDataSource = self
        
        searchTableView.dataSource = self
        searchTableView.delegate = self
        let nib = UINib(nibName: "SearchTableViewCell", bundle: nil)
        searchTableView.register(nib, forCellReuseIdentifier: "SearchTableViewCell")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
         view.endEditing(true)
   }
}


extension MoreViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        queryText = text
        APIHelper.shared.callSessionRequest(text: text, page: page) { book in
            guard let book else {
                print("nooo")
                return
                
            }
            
            print(book)
            self.isEnd = book.meta.isEnd
            self.bookList.append(contentsOf: book.documents)
        }
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        queryText = ""
        bookList = []
        searchTableView.reloadData()
    }
}


extension MoreViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        // queryText(검색어)가 비었다면 종료
        guard !queryText.isEmpty else { return }
        
        for indexPath in indexPaths {
            if bookList.count - 1 == indexPath.row && isEnd == false && page < 30 {
                page += 1
                APIHelper.shared.callSessionRequest(text: queryText, page: page) { book in
                    
                    guard let book else { return }
                    self.bookList.append(contentsOf: book.documents)
                    self.isEnd = book.meta.isEnd
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as? SearchTableViewCell else {
            return UITableViewCell()
        }
        let book = bookList[indexPath.row]
        cell.document = book
        cell.configurateCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let book = bookList[indexPath.row]
        saveBookData(book: book)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}



