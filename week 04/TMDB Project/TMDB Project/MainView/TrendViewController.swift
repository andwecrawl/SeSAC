//
//  ViewController.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/11.
//

import UIKit

class TrendViewController: UIViewController {

    @IBOutlet weak var trendTableView: UITableView!
    
    var list: [TrendsMedia] = []
    var page: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Today's Trend"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.2.circlepath"), style: .plain, target: self, action: #selector(reloadAll))
        
        
        TMDBManager.shared.callRequest(page: page) { element in
            let id = element["id"].intValue
            let title = element["title"].stringValue
            let mediaType = element["media_type"].stringValue
            let genreInt = element["genre_ids"][0].intValue
            var genre: String = ""
            // 장르가 제때 안 들어감... ㅠ_ㅠ
            URL.media = Media(rawValue: mediaType) ?? .movie
            DispatchQueue.global().sync {
                TMDBManager.shared.callGenereRequest(url: URL.genreURL, id: genreInt) { content in
                    genre = content["name"].stringValue
                }
            }
            let date = element["release_date"].stringValue
            let overview = element["overview"].stringValue
            let backdropImage = element["backdrop_path"].stringValue
            let posterImage = element["poster_path"].stringValue
            let newMedia = TrendsMedia(id: id, title: title, mediaType: mediaType, genre: genre, date: date, overview: overview, backdropImage: backdropImage, posterImage: posterImage)
            print(newMedia)
            self.list.append(newMedia)
            self.trendTableView.reloadData()
        }
        
        trendTableView.dataSource = self
        trendTableView.delegate = self
        
        let nib = UINib(nibName: MovieTableViewCell.identifier, bundle: nil)
        trendTableView.register(nib, forCellReuseIdentifier: MovieTableViewCell.identifier)
        
        trendTableView.reloadData()
    }
    
    
    @objc func reloadAll() {
        trendTableView.reloadData()
        print(list)
    }
}


extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier) as? MovieTableViewCell else { return UITableViewCell()}
        
        let row = indexPath.row
        cell.media = list[row]
        cell.configurateCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 클릭했을 때 코드
        // 이후 세부 화면 구현
        tableView.reloadRows(at: [indexPath], with: .none) // 내부로 들어가고 클릭 안 한 척 ^_^
    }
    
}

