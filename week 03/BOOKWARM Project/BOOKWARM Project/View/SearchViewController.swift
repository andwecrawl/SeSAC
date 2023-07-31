//
//  ViewController.swift
//  BOOKWARM Project
//
//  Created by yeoni on 2023/07/31.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var detailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designInitalSetting()
        addLeftBarItem()
    }
    
    func designInitalSetting() {
        title = "검색"
        detailLabel.text = "상세 검색"
        detailLabel.textAlignment = .center
        detailLabel.font = .boldSystemFont(ofSize: 30)
    }
    
    func addLeftBarItem() {
        let xMark = UIImage(systemName: "xmark")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: xMark, style: .plain, target: self, action: #selector(closeButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc
    func closeButtonTapped() {
        dismiss(animated: true)
    }

}

