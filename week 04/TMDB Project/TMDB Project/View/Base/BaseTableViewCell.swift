//
//  BaseTableViewCell.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/28.
//

import UIKit
import SnapKit

class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() { // addSubview
    }
    
    func setConstraints() { // 제약조건
    }
}


