//
//  SecondTabViewController.swift
//  firstApp
//
//  Created by yeoni on 2023/07/27.
//

import UIKit

class SecondTabViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    
    let userDefaults = UserDefaults.standard
    
    // 탭바 컨트롤러: 탭 클릭 전까지 ViewDidLoad는 호출되지 않음
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let count = UserDefaults.standard.integer(forKey: "count")
        resultLabel.text = "\(count)"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("gg")
        let count = userDefaults.integer(forKey: "count")
        resultLabel.text = "\(count)"
    }
    
    
    
}
