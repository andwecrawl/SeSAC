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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        searchBar.delegate = self
//        searchBar.placeholder = "검색어를 입력해 주세요."
//        searchBar.showsCancelButton = true
//        searchTableView.tableHeaderView = searchBar
        
        searchTableView.dataSource = self
        searchTableView.delegate = self
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        callRequest(text: text)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        bookList = []
    }

    func callRequest(text: String) {
        
        guard let text = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = "https://dapi.kakao.com/v3/search/book?target=title&query=\(text)"
        let header: HTTPHeaders = ["Authorization": "KakaoAK cf98a391517cae5208a42c51880b5107"]
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
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
                print(self.bookList)
                self.searchTableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
        
    }

}


extension MoreViewController: UITableViewDelegate, UITableViewDataSource {
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
