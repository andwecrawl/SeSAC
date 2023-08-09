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
        searchTableView.reloadData()
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
        // queryText(검색어)가 비었다면 종료
        guard !queryText.isEmpty else { return }
        
        // 이 for문에서 pagenation이 구현된다.
        // indexPath(각 셀의 위치)의 배열인 indexPaths를 돌면서 비교한다.
        // 그 안에서 만약 indexPath가 bookList.count가 같다면 그 부분이 페이지의 끝이라는 소리니까
        // 페이지가 끝나기 전에 데이터를 가져오는 조건을 설정해 준다.
        // 또, 중요한 점이 json 데이터를 가져올 때 meta section에서 페이지가 끝났는지 볼 수 있는 is_end가 있다. (queryString 값은 각 json마다 다를 수 있음)
        // 이 is_end를 서버에서 매번 가져오는데, 이 페이지가 끝 페이지가 아닐 때 새 페이지를 로드할 수 있으므로 이 값이 false일 때 로드하도록 한다.
        // 또한, 최대 페이지 값을 설정해 주어 서버에서 제공해 주는 데이터의 페이지값을 넘는 걸 요청하여 오류가 나지 않도록 한다.
        // Kakao 책 검색 API의 경우에는 size와 page 값은 최대 50까지였다.
        for indexPath in indexPaths {
            if bookList.count - 1 == indexPath.row && isEnd == false && page < 30 {
                // 위 조건이 맞으면 새 페이지를 가져와야 하므로, 페이지 수를 증가시킨다.
                page += 1
                // 이후 callRequest(text:page:) 함수를 실행하여 서버에 데이터를 요청한다.
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
