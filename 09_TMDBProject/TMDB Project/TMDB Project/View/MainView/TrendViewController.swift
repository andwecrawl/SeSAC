//
//  ViewController.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/11.
//

import UIKit

import Tabman
import Pageboy

class TrendViewController: TabmanViewController {
    
    let bar = setCustomButtonBar()
    let viewControllers = [TabViewController(), TabViewController(), TabViewController(), TabViewController()]
        
    var trendsList: TMDB = TMDB(page: 0, results: [], totalPages: 0, totalResults: 0)
    
    var personList: Person = Person(page: 0, results: [], totalPages: 0, totalResults: 0)
    
    var genreList: [String] = []
    var currentPage: Int = 0
    var page: Int = 1
    var isEnd: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        setConstraints()
        configureView()
    }
    
    
    func setNavigationBar() {
        title = "Today's Trend"
    }
    
    func setConstraints() {
        self.dataSource = self
        self.isScrollEnabled = false
        addBar(bar, dataSource: self, at: .top)
    }
    
    static func setCustomButtonBar() -> TMBar.ButtonBar {
        let bar = TMBar.ButtonBar()
        
        bar.layout.transitionStyle = .snap
        bar.layout.contentMode = .fit
        bar.layout.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        
        bar.backgroundView.style = .blur(style: .light)
        bar.buttons.customize { (button) in
            button.tintColor = .systemGray4
            button.selectedTintColor = .black
            button.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            button.selectedFont = UIFont.systemFont(ofSize: 15, weight: .semibold)
        }
        bar.indicator.weight = .custom(value: 2)
        bar.indicator.tintColor = .black
        
        return bar
    }
    
    func configureView() {
        view.backgroundColor = .white
        viewControllers.forEach {
            $0.tableView.delegate = self
            $0.tableView.dataSource = self
        }
        
        TMDBRequest(index: currentPage) {
            print("reload")
            self.viewControllers[0].tableView.reloadData()
        }
    }
    
    
    func TMDBRequest(index: Int, completion: @escaping () -> ()) {
        var segment: Trends = .all
        segment.setIndex(index)
        
        if segment == .person && personList.results.isEmpty {
            TMDBManager.shared.callPersonRequest { [weak self] person in
                print("person Request")
                guard let self else { return }
                guard let person else { return }
                
                self.personList = person
                completion()
            }
        } else {
            TMDBManager.shared.callRequestCodable(segment: segment) { [weak self] data, genre in
                print("another Request")
                guard let self else { return }
                
                self.trendsList = data
                self.genreList = genre
                completion()
            }
        }
    }
}


extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currentPage == 3 {
            return personList.results.count
        } else {
            return trendsList.results.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if currentPage == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.identifier) as? PersonTableViewCell else { return UITableViewCell()}
            let row = indexPath.row
            let person = personList.results[row]
            cell.people = person
            
            cell.configureCell()
            
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
        
        if currentPage == 3 {
            return 150
        } else {
            return 400
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if currentPage == 3 {
            return
        }
        
        let vc = DetailTableViewController()
        
        vc.media = trendsList.results[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
}




extension TrendViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        if currentPage != index {
            currentPage = index
            TMDBRequest(index: currentPage) {
                print("changed?")
                self.viewControllers[index].tableView.reloadData()
            }
        }
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return .at(index: 0)
    }

    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "All")
        case 1:
            return TMBarItem(title: "Movie")
        case 2:
            return TMBarItem(title: "TV")
        case 3:
            return TMBarItem(title: "Actor")
        default:
            let title = "Page \(index)"
            return TMBarItem(title: title)
        }
    }
}
