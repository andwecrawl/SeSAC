//
//  ViewController.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/11.
//

import UIKit

class TrendViewController: BaseViewController {

    let mainView = TrendView()
    
    override func loadView() {
        self.view = mainView
    }
    
    var trendsList: TMDB = TMDB(page: 0, results: [], totalPages: 0, totalResults: 0) {
        didSet {
            mainView.tableView.reloadData()
        }
    }
    
    var genreList: [String] = []
    var page: Int = 1
    var isEnd: Bool = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
    }
    
    
    func setNavigationBar() {
        title = "Today's Trend"
    }
    

    override func configureView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        TMDBRequest(segment: .all)
        mainView.segmentedControl.selectedSegmentIndex = 0
        mainView.segmentedControl.addTarget(self, action: #selector(segmentValueChanged), for: UIControl.Event.valueChanged)
    }
    
    @objc func segmentValueChanged() {
        let index = mainView.segmentedControl.selectedSegmentIndex
        switch index {
        case 0:
            TMDBRequest(segment: .all)
        case 1:
            TMDBRequest(segment: .movie)
        case 2:
            TMDBRequest(segment: .tv)
        case 3:
            TMDBRequest(segment: .person)
            print("Person")
//            TMDBRequest(segment: .person)
        default:
            print("anybodyThere")
        }
        mainView.tableView.reloadData()
    }
    
    func TMDBRequest(segment: Trends) {
        if segment == .person {
            print("person???")
            TMDBManager.shared.callPersonRequest { person in
                print("come?")
                guard let person else {
                    print("nil")
                    return
                }
                print("hello?")
            }
        } else {
            TMDBManager.shared.callRequestCodable(segment: segment) { data, genre in
                self.trendsList = data
                self.genreList = genre
                self.mainView.tableView.reloadData()
            }
        }
    }
}


extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if mainView.segmentedControl.selectedSegmentIndex == 3 {
            return 4
        } else {
            return trendsList.results.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let segmentIndex = mainView.segmentedControl.selectedSegmentIndex
        
        if segmentIndex == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.identifier) as? PersonTableViewCell else { return UITableViewCell()}
            cell.nameLabel.text = "hello"
            cell.knownForLabel.text = "acting"
            cell.genderLabel.text = "male"
            cell.popularityLabel.text = "veryfamous"
            cell.knownLabel.text = "아무튼유명한거"
            return cell
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendTableViewCell.identifier) as? TrendTableViewCell else { return UITableViewCell()}

                let row = indexPath.row
                cell.media = trendsList.results[row]
                if page == 1 {
                    cell.genre = genreList[row]
                } else if page > 1 {
                    cell.genre = genreList[row + (page * 20)]
                }
                cell.configurateCell()
            
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let segmentIndex = mainView.segmentedControl.selectedSegmentIndex
        if segmentIndex == 3 {
            return 200
        } else {
            return 400
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 클릭했을 때 코드
        // 이후 세부 화면 구현
        guard let vc = storyboard?.instantiateViewController(withIdentifier: DetailTableViewController.identifier) as? DetailTableViewController else { return }
       
        vc.media = trendsList.results[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        tableView.reloadRows(at: [indexPath], with: .none) // 내부로 들어가고 클릭 안 한 척 ^_^
    }
    
}

