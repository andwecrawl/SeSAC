//
//  BaseViewController.swift
//  Mobbie
//
//  Created by yeoni on 2023/11/09.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    
    
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
