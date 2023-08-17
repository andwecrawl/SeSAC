//
//  ViewController.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/11.
//

import UIKit

class TrendViewController: UIViewController {

    @IBOutlet weak var trendTableView: UITableView!
    
    var trendsList: TMDB = TMDB(page: 0, results: [], totalPages: 0, totalResults: 0) {
        didSet {
            trendTableView.reloadData()
        }
    }
    var genreList: [String] = []
    var page: Int = 1
    var isEnd: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Today's Trend"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.2.circlepath"), style: .plain, target: self, action: #selector(reloadAll))
        
        
        TMDBManager.shared.callRequestCodable { data, genre in
            self.trendsList = data
            self.genreList = genre
            print("trend: \(data)")
            print("genre: \(genre)")
            self.trendTableView.reloadData()
        }
        
        trendTableView.prefetchDataSource = self
        trendTableView.dataSource = self
        trendTableView.delegate = self
        
        let nib = UINib(nibName: MovieTableViewCell.identifier, bundle: nil)
        trendTableView.register(nib, forCellReuseIdentifier: MovieTableViewCell.identifier)
    }
    
    
    @objc func reloadAll() {
        trendTableView.reloadData()
    }

}


extension TrendViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trendsList.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier) as? MovieTableViewCell else { return UITableViewCell()}
        
        let row = indexPath.row
        cell.media = trendsList.results[row]
        cell.genre = genreList[row]
        cell.configurateCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 클릭했을 때 코드
        // 이후 세부 화면 구현
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "DetailTableViewController") as? DetailTableViewController else { return }
       
        vc.media = trendsList.results[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        tableView.reloadRows(at: [indexPath], with: .none) // 내부로 들어가고 클릭 안 한 척 ^_^
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if bundleList.list.count - 1 == indexPath.row && isEnd == false && page < 50 {
                // 위 조건이 맞으면 새 페이지를 가져와야 하므로, 페이지 수를 증가시킨다.
                page += 1
                // 이후 callRequest(text:page:) 함수를 실행하여 서버에 데이터를 요청한다.
                TMDBManager.shared.callRequestCodable { data, genre in
                    
                    
                }
//                TMDBManager.shared.callRequest(page: page) {
//                    self.reloadAll()
//                }
                print("page: \(page)")
            }
        }
    }
}

