//
//  BaseViewController.swift
//  SACdyBuddy
//
//  Created by yeoni on 2023/11/09.
//

import UIKit

class BaseViewController: ViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        setConstraints()
        configureView()
    }
    
    func configureHierarchy() {
        view.backgroundColor = .white
    }
    
    func setConstraints() {
        
    }
    
    func configureView() {
        
        
    }
    
}