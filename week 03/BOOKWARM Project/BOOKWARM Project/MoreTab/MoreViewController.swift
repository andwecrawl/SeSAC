//
//  MoreViewController.swift
//  BOOKWARM Project
//
//  Created by yeoni on 2023/08/08.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

struct Book {
    var title: String
    var author: String
    var publisher: String
    var price: String
    var imageURL: String
    
    var description: String {
        return "\(author) · \(publisher) · \(price)"
    }
}

class MoreViewController: UIViewController, UISearchBarDelegate {

    let searchBar = UISearchBar()
    
    @IBOutlet weak var searchTableView: UITableView!
    
    var bookList: [Book] = []
    var isEnd: Bool = false
    var page: Int = 1
    var queryText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchTableView.prefetchDataSource = self
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        queryText = text
        callRequest(text: text, page: page)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        queryText = ""
        bookList = []
    }

    func callRequest(text: String, page: Int) {
        
        guard let text = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = "https://dapi.kakao.com/v3/search/book?target=title&query=\(text)&size=20&page=\(page)"
        print(url)
        let header: HTTPHeaders = ["Authorization": "KakaoAK cf98a391517cae5208a42c51880b5107"]
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)

                self.isEnd = json["meta"]["is_end"].boolValue
                let items = json["documents"].arrayValue
                
                for book in items {
                    let title = book["title"].stringValue
                    let price = book["price"].stringValue
                    let publisher = book["publisher"].stringValue
                    var authors: String {
                        if book["authors"].count == 1 {
                            return book["authors"][0].stringValue
                        } else {
                            let mainAuthor: String = book["authors"][0].stringValue
                            let nums = book["authors"].count - 1
                            return mainAuthor + "외 \(nums)명"
                        }
                    }
                    var imageURL: String {
                        if book["thumbnail"].stringValue.isEmpty {
                            return "noImage"
                        } else {
                            return book["thumbnail"].stringValue
                        }
                    }
                    
                    self.bookList.append(Book(title: title, author: authors, publisher: publisher, price: price, imageURL: imageURL))
                    
                }
                
                self.searchTableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
        
    }

}


extension MoreViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard !queryText.isEmpty else { return }
        for indexPath in indexPaths {
            if bookList.count - 1 == indexPath.row && isEnd == false && page < 30 {
                page += 1
                callRequest(text: queryText, page: page)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell")!
        let book = bookList[indexPath.row]
        cell.textLabel?.text = book.title
        cell.detailTextLabel?.text = book.description
        if book.imageURL == "noImage" {
            cell.imageView?.image = UIImage(named: book.imageURL)
        } else {
            let url = URL(string: book.imageURL)
            cell.imageView?.kf.setImage(with: url)
        }
        return cell
    }
    
    
    
}
