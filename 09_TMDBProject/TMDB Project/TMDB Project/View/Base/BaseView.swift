//
//  BaseView.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/28.
//

import UIKit
import SnapKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() { // addSubview
    }
    
    func setConstraints() { // 제약조건
    }
}
