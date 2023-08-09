//
//  ViewController.swift
//  PracticeAPi
//
//  Created by yeoni on 2023/08/09.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

struct Video {
    let author: String
    let date: String
    let time: Int
    let thumbnail: String
    let title: String
    let link: String
    
    var contents: String {
        return "\(author) | \(time)회\n\(date)"
    }
}

class VideoViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var videoTableView: UITableView!
    
    
    var page = 1
    var videoList: [Video] = []
    var isEnd: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoTableView.delegate = self
        videoTableView.dataSource = self
        videoTableView.prefetchDataSource = self
        videoTableView.rowHeight = 140
        
        searchBar.delegate = self
        
    }
    
    
    // searchBar는 searchbar delegate 있음
    // action 연결 대신 delegate!!
    
    
    func callRequest(query: String, pages: Int) {
        guard let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        // .addingPercentEncoding(withAllowedChracters: .urlQueryAllowed)!
        
        // query string에서 ?와 &의 차이1!!!!! 공부해 볼 것
        let url = "https://dapi.kakao.com/v2/search/vclip?query=\(text)&size=10&page=\(page)"
        // AF = Session.default => 얘네는 결국에 URL SESSION으로 이루어져 있다... ^_^
        // headers: HTTPHeaders 쓸 수도 안 쓸 수도 있으니 optional~~
        // 이 친구의 type은 결국 Dictionary형태임
        let header: HTTPHeaders = ["Authorization": APIKey.kakaoAPI.rawValue]
        print(url)
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let statusCode = response.response?.statusCode ?? 500
                
                // 상태 코드에 대한 대응!!!!!!!!!!!!!!!!!
                // 400번 / 500번이 뭘 의미하는지 어떻게 알 수 있을까?
                // => API 문서!!!
                // 오류가 났을 때 대응을 어떻게 하면 되나를 찾아보면 좋음
                if statusCode == 200 {
                    
                    self.isEnd = json["meta"]["is_end"].boolValue
                    
                    
                    for item in json["documents"].arrayValue {
                        
                        let title = item["title"].stringValue
                        let date = item["datetime"].stringValue
                        let author = item["author"].stringValue
                        let link = item["link"].stringValue
                        let thumbnail = item["thumbnail"].stringValue
                        let time = item["play_time"].intValue
                        self.videoList.append(Video(author: author, date: date, time: time, thumbnail: thumbnail, title: title, link: link))
                    }
                    
                    
                    
                    print(self.videoList)
                    self.videoTableView.reloadData()
                    
                } else {
                    print("문제가 발생했어요. 잠시 후 다시 시도해 주세요!")
                }
                
                
            case .failure(let error):
                // API마다 다른데,
                // API 중에 에러 메세지에 대한 부분을 상세하게 표현해 주는 API들이 있음
                // 그러면 어떤 에러가 떴는지 보여주는 게...
                // 상태 코드에 대한 처리 / 예외 처리에 대한 처리를 해 본 적이 있다~ 라고 하는 게 좋음
                
                print(error)
            }
        }
    }
    
    
    
}


// UITableViewDataSourcePrefetching
// 
extension VideoViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    // 셀이 화면에 보이기 직전에 필요한 리소스를 미리 다운받는 기능
    // 이 시점에서 이미지를 다운받아야 빠르게!!! 데이터를 받아올 수 있음
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            if videoList.count - 1 == indexPath.row && page < 15 && isEnd == false {
                page += 1
                callRequest(query: searchBar.text!, pages: page)
            }
        }
    }
    
    // 취소 기능: 직접 취소하는 기능을 구현해 주어야 함!!
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("=== 취소 \(indexPaths)")
        // 사용자가 스크롤을 빨리 내리는 경우 다운로드를 받고 있는 데이터를 굳이 더 받을 필요가 없음
        // 그래서 다운로드 받고 있는 데이터를 reset / cancel해주면 댐!!
        // 직접 기능 구현을 해 줘야 하는 곳이지만 왜 있는지 정도만 알면 댐
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoList.count
    }
    
    // 사용자가 화면을 볼 때 실행되는 method
    // 호출 전에 prefecting!!!! method가 먼저 실행댐
    // 이 셀이 보여지기 직전에 미리 다운로드 받는 거임
    // pageCount 중요!!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell") as? VideoTableViewCell else {
            return UITableViewCell()
        }
        
        let row = indexPath.row
        print(videoList[row])
        cell.titleLabel.text = videoList[row].title
        cell.contentLabel.text = videoList[row].contents
        let url = URL(string: videoList[row].thumbnail)
        cell.thumbnailImageView.kf.setImage(with: url)
        
        return cell
        
    }
}


extension VideoViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        page = 1 // 새로운 검색어이기 때문에!
        videoList.removeAll() // 모두 삭제
        
        guard let text = searchBar.text else {
            return }
        callRequest(query: text, pages: page)
        
    }
}

