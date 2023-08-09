//
//  VideoViewController.swift
//  SeSACWeek4
//
//  Created by yeoni on 2023/08/09.
//

import UIKit

import Alamofire
import SwiftyJSON


struct Video {
    let author: String
    let date: String
    let time: Int
    let thumbnail: String
    let title: String
}


class VideoViewController: UIViewController {
        
    var videoList: [String] = []

        override func viewDidLoad() {
                super.viewDidLoad()

        }




        
        func callRequest() {
            let text = "아이유".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                let url = "https://dapi.kakao.com/v2/search/vclip?query=\(text)"
        // AF = Session.default => 얘네는 결국에 URL SESSION으로 이루어져 있다... ^_^
                // headers: HTTPHeaders 쓸 수도 안 쓸 수도 있으니 optional~~
                // 이 친구의 type은 결국 Dictionary형태임
                let header: HTTPHeaders = ["Authorization": "kakaoAK $cf98a391517cae5208a42c51880b5107"]

                AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")

                                for item in json["documents"].arrayValue {
                                        let title = item["title"].stringValue
                                        self.videoList.append(title)
                                }

                                print(self.videoList)


            case .failure(let error):
                print(error)
            }
        }
        }



}
