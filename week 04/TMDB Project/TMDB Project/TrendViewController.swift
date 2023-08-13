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
        
        trendTableView.dataSource = self
        trendTableView.delegate = self
        
        let nib = UINib(nibName: MovieTableViewCell.identifier, bundle: nil)
        trendTableView.register(nib, forCellReuseIdentifier: MovieTableViewCell.identifier)
        
    }
    

}


extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier) as? MovieTableViewCell else { return UITableViewCell()}

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    
}

