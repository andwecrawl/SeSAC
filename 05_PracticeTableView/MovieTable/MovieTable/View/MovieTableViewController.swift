//
//  MovieTableViewController.swift
//  MovieTable
//
//  Created by yeoni on 2023/07/28.
//

import UIKit

class MovieTableViewController: UITableViewController {

    let list = MovieInfo().movie
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // 1. 셀 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    // cell design
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieTableViewCell") as! MovieTableViewCell
        
        let row = list[indexPath.row]
        
        cell.configurateCell(row: row)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
}
