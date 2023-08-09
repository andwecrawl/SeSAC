//
//  MovieViewController.swift
//  SeSACWeek4
//
//  Created by yeoni on 2023/08/08.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftyJSON

struct Movie {
        var movieTitle: String
        var release: String

}


class MovieViewController: UIViewController {
    
    @IBOutlet var movieTableView: UITableView!
    
    var movieList: [Movie] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTableView.rowHeight = 60
        movieTableView.dataSource = self
        movieTableView.delegate = self
        
//        callRequest()
        
    }
    
    func callRequest() {

        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=20120101"
        // AF = Session.default => 얘네는 결국에 URL SESSION으로 이루어져 있다... ^_^
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
//                let name1 = json["boxOfficeResult"]["dailyBoxOfficeList"][0]["movieNm"].stringValue
//                let name2 = json["boxOfficeResult"]["dailyBoxOfficeList"][1]["movieNm"].stringValue
//                let name3 = json["boxOfficeResult"]["dailyBoxOfficeList"][2]["movieNm"].stringValue
//
//                self.movieList.append(contentsOf: [name1, name2, name3])
                
//                for item in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
//
//                    let movieNm = item["movieNm"].stringValue
//                    let openDt = item["openDt"].stringValue
//
//                    let data = Movie(movieTitle: movieNm, release: openDt)
//                    self.movieList.append(data)
//
//                }
//
//
//                self.movieTableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
}



extension MovieViewController: UITableViewDelegate, UITableViewDataSource {

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return 20 //movieList.count
            
        }

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell")!
//        cell.textLabel?.text = movieList[indexPath.row].movieTitle
//        cell.detailTextLabel?.text = movieList[indexPath.row].release
        
            return cell
        }


}

