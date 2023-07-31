//
//  DetailViewController.swift
//  BOOKWARM Project
//
//  Created by yeoni on 2023/08/01.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailLabel: UILabel!
    
    var movieName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designInitalSetting()
    }
    
    func designInitalSetting() {
        title = movieName
        detailLabel.text = "상세 정보"
        detailLabel.font = .boldSystemFont(ofSize: 25)
        detailLabel.textAlignment = .center
    }
    
}
