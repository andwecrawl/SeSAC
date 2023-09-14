//
//  BaseViewController.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/28.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setConstraints()
    }
    
    func configureView() { // addSubview
        view.backgroundColor = .white
    }
    
    func setConstraints() { // 제약조건
    }

    
}
